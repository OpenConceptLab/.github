#!/usr/bin/env bash
# cleanup-default-labels.sh — Delete GitHub default labels from all active repos.
# Keeps "good first issue" and "help wanted" (GitHub special labels).
#
# Usage:
#   ./cleanup-default-labels.sh --dry-run     # preview (default)
#   ./cleanup-default-labels.sh --execute     # apply changes
#   ./cleanup-default-labels.sh --execute ocl_issues   # single repo
#
# Requires: gh CLI (authenticated)

set -euo pipefail

ORG="OpenConceptLab"
DRY_RUN=true

REPOS=()
for arg in "$@"; do
  case "$arg" in
    --execute) DRY_RUN=false ;;
    --dry-run) DRY_RUN=true ;;
    *) REPOS+=("$arg") ;;
  esac
done

if [[ ${#REPOS[@]} -eq 0 ]]; then
  while IFS= read -r name; do
    REPOS+=("$name")
  done < <(gh repo list "$ORG" --limit 200 --json name,isArchived \
    --jq '.[] | select(.isArchived == false) | .name' | sort)
fi

# GitHub default labels to delete
DEFAULT_LABELS=(
  "bug"
  "documentation"
  "duplicate"
  "enhancement"
  "invalid"
  "question"
  "wontfix"
)

if $DRY_RUN; then
  echo "=== DRY RUN === (use --execute to apply changes)"
else
  echo "=== EXECUTING ==="
fi
echo "Cleaning default labels from ${#REPOS[@]} repos"
echo ""

DELETED=0
SKIPPED=0

for repo in "${REPOS[@]}"; do
  # Get existing labels for this repo
  existing=$(gh label list --repo "$ORG/$repo" --limit 200 --json name --jq '.[].name' 2>/dev/null || true)

  found=()
  for label in "${DEFAULT_LABELS[@]}"; do
    if echo "$existing" | grep -qxF "$label"; then
      found+=("$label")
    fi
  done

  if [[ ${#found[@]} -eq 0 ]]; then
    continue
  fi

  echo "── $ORG/$repo (${#found[@]} defaults) ──"
  for label in "${found[@]}"; do
    if $DRY_RUN; then
      echo "  DELETE: $label"
      DELETED=$((DELETED + 1))
    else
      if gh label delete "$label" --repo "$ORG/$repo" --yes 2>/dev/null; then
        echo "  DELETED: $label"
        DELETED=$((DELETED + 1))
      else
        echo "  SKIP: $label"
        SKIPPED=$((SKIPPED + 1))
      fi
    fi
  done
  echo ""
done

echo "═══════════════════════════════════"
echo "Done. Deleted: $DELETED | Skipped: $SKIPPED"
