#!/usr/bin/env bash
# migrate-labels.sh — Phase 2: Migrate old labels to new taxonomy on ocl_issues.
#
# Usage:
#   ./migrate-labels.sh --dry-run     # preview changes (default)
#   ./migrate-labels.sh --execute     # apply changes
#
# Uses REST API PATCH (single call per issue) for speed.
# Fetches all issues once, processes in memory via Python.
#
# Requires: gh CLI (authenticated), python3

set -euo pipefail

REPO="OpenConceptLab/ocl_issues"
DRY_RUN=true

for arg in "$@"; do
  case "$arg" in
    --execute) DRY_RUN=false ;;
    --dry-run) DRY_RUN=true ;;
  esac
done

if $DRY_RUN; then
  echo "=== DRY RUN === (use --execute to apply changes)"
else
  echo "=== EXECUTING === (changes will be applied)"
fi
echo ""

# ─── Fetch all issues with their labels ─────────────────────────────
echo "Fetching all issues from $REPO..."
ISSUES_FILE=$(mktemp)

gh api "repos/$REPO/issues" --paginate \
  --jq '.[] | {number, state, labels: [.labels[].name]}' \
  -X GET -f state=all -f per_page=100 > "$ISSUES_FILE"

TOTAL=$(wc -l < "$ISSUES_FILE" | tr -d ' ')
echo "Fetched $TOTAL issues."
echo ""

# ─── Compute migration plan and optionally execute via Python ───────
PYTHONUNBUFFERED=1 python3 -u - "$ISSUES_FILE" "$DRY_RUN" "$REPO" <<'PYEOF'
import json, sys, subprocess, urllib.parse
sys.stdout.reconfigure(line_buffering=True)

issues_file = sys.argv[1]
dry_run = sys.argv[2] == "true"
repo = sys.argv[3]

# Label mapping: old → new
MAPPING = {
    "bug": "type/bug",
    "Feature": "type/feature",
    "enhancement": "type/feature",
    "Design": "type/feature",
    "documentation": "type/docs",
    "documentation-needed": "type/docs",
    "tech debt": "type/refactor",
    "performance": "type/feature",
    "breaking-change": "type/feature",
    "infra": "type/infra",
    "V3": "component/web",
    "web3": "component/web",
    "v3-foundation": "component/web",
    "web2": "component/web",
    "ui": "component/web",
    "UX / UI": "component/web",
    "DS": "component/web",
    "api2": "component/api",
    "fhir": "component/fhir",
    "For FHIR testing": "component/fhir",
    "openmrs": "component/omrs",
    "affects-ocl-client": "component/omrs",
    "analytics": "component/analytics",
    "ocldev": "component/api",
    "ES": "component/api",
    "bulk-import": "component/api",
    "content": "component/content",
    "community site": "component/docs",
    "Logging": "component/infra",
    "errbit": "component/infra",
    "Priority: High": "priority/high",
    "Priority: Medium": "priority/medium",
    "Priority: Low": "priority/low",
    "top-priority": "priority/critical",
    "blocker": "priority/critical",
}

REMOVE_ONLY = {
    "Epic", "Project-level Epic", "CIEL Implementer", "OHIE Must-Haves", "PM",
    "Review before Dev", "demo", "demo-needed", "duplicate", "invalid", "question",
    "wontfix", "intro", "medium-difficulty", "could-improve", "data-issue",
    "environment-specific", "requires-es-index", "report", "post-launch",
    "parking-lot", "production", "qa", "staging", "scheduled", "reviewed/keep",
}

ALL_OLD = set(MAPPING.keys()) | REMOVE_ONLY | {"discussion-needed"}

# Load issues
issues = []
with open(issues_file) as f:
    for line in f:
        line = line.strip()
        if line:
            issues.append(json.loads(line))

# Compute per-issue plan
plans = []
label_stats = {}  # old_label -> count of issues affected

for issue in issues:
    number = issue["number"]
    state = issue["state"]
    current = set(issue["labels"])

    adds = set()
    removes = set()

    for label in current:
        if label in MAPPING:
            adds.add(MAPPING[label])
            removes.add(label)
            label_stats.setdefault(label, 0)
            label_stats[label] += 1
        elif label in REMOVE_ONLY:
            removes.add(label)
            label_stats.setdefault(label, 0)
            label_stats[label] += 1
        elif label == "discussion-needed":
            removes.add(label)
            label_stats.setdefault(label, 0)
            label_stats[label] += 1
            if state == "open":
                adds.add("signal/needs-spec")

    if not adds and not removes:
        continue

    new_labels = sorted((current - removes) | adds)
    plans.append({
        "number": number,
        "state": state,
        "adds": sorted(adds),
        "removes": sorted(removes),
        "new_labels": new_labels,
    })

# Print summary
print("── Migration summary by label ──\n")
for old_label in sorted(MAPPING.keys(), key=str.lower):
    if old_label in label_stats:
        print(f"  {old_label} ({label_stats[old_label]} issues) → {MAPPING[old_label]}")

for old_label in sorted(REMOVE_ONLY):
    if old_label in label_stats:
        print(f"  {old_label} ({label_stats[old_label]} issues) → REMOVE")

dn_count = label_stats.get("discussion-needed", 0)
if dn_count:
    dn_open = sum(1 for p in plans if "signal/needs-spec" in p["adds"])
    print(f"\n  discussion-needed: {dn_open} open → +signal/needs-spec, {dn_count - dn_open} closed → remove only")

print(f"\nTotal issues to update: {len(plans)}\n")

# Apply or dry-run
print("── Applying label changes ──\n")
done = 0
errors = 0

for plan in plans:
    number = plan["number"]
    state = plan["state"]
    adds_str = ", ".join(plan["adds"])
    removes_str = ", ".join(plan["removes"])

    if dry_run:
        print(f"  #{number} ({state}): +[{adds_str}] -[{removes_str}]")
        done += 1
    else:
        payload = json.dumps({"labels": plan["new_labels"]})
        result = subprocess.run(
            ["gh", "api", f"repos/{repo}/issues/{number}",
             "--method", "PATCH", "--input", "-"],
            input=payload, capture_output=True, text=True
        )
        if result.returncode == 0:
            done += 1
            if done % 50 == 0:
                print(f"  ... {done} / {len(plans)} issues updated")
        else:
            print(f"  ERROR #{number}: {result.stderr.strip()}")
            errors += 1

print(f"\n  Updated: {done} issues (errors: {errors})\n")

# Delete old labels
print("── Deleting old labels ──\n")
deleted = 0
for label in sorted(ALL_OLD):
    encoded = urllib.parse.quote(label, safe="")
    if dry_run:
        print(f"  DELETE: {label}")
        deleted += 1
    else:
        result = subprocess.run(
            ["gh", "api", f"repos/{repo}/labels/{encoded}", "--method", "DELETE"],
            capture_output=True, text=True
        )
        if result.returncode == 0:
            print(f"  DELETED: {label}")
            deleted += 1
        else:
            print(f"  SKIP (not found): {label}")

print(f"\n{'='*35}")
print(f"Done. Issues updated: {done} | Labels deleted: {deleted} | Errors: {errors}")
PYEOF

rm -f "$ISSUES_FILE"
