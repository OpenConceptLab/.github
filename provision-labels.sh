#!/usr/bin/env bash
# provision-labels.sh — Create/update OCL labels across all active repos.
# Idempotent: safe to re-run. Updates color/description if label exists.
#
# Usage:
#   ./provision-labels.sh                  # all active repos
#   ./provision-labels.sh ocl_issues       # single repo
#   ./provision-labels.sh --dry-run        # preview without changes
#
# Requires: gh CLI (authenticated), yq

set -euo pipefail

ORG="OpenConceptLab"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LABELS_FILE="$SCRIPT_DIR/labels.yml"
DRY_RUN=false

# Parse args
REPOS=()
for arg in "$@"; do
  if [[ "$arg" == "--dry-run" ]]; then
    DRY_RUN=true
  else
    REPOS+=("$arg")
  fi
done

# If no repos specified, get all active (non-archived) repos
if [[ ${#REPOS[@]} -eq 0 ]]; then
  while IFS= read -r name; do
    REPOS+=("$name")
  done < <(gh repo list "$ORG" --limit 200 --json name,isArchived \
    --jq '.[] | select(.isArchived == false) | .name' | sort)
fi

if ! command -v yq &> /dev/null; then
  echo "Error: yq is required. Install with: brew install yq"
  exit 1
fi

LABEL_COUNT=$(yq 'length' "$LABELS_FILE")
echo "Provisioning $LABEL_COUNT labels across ${#REPOS[@]} repos"
if $DRY_RUN; then
  echo "(DRY RUN — no changes will be made)"
fi
echo ""

CREATED=0
UPDATED=0
SKIPPED=0
ERRORS=0

for repo in "${REPOS[@]}"; do
  echo "── $ORG/$repo ──"

  # Fetch existing labels into a temp file (name<TAB>color per line)
  EXISTING=$(mktemp)
  gh label list --repo "$ORG/$repo" --limit 200 --json name,color \
    --jq '.[] | [.name, .color] | @tsv' > "$EXISTING" 2>/dev/null || true

  for i in $(seq 0 $((LABEL_COUNT - 1))); do
    name=$(yq -r ".[$i].name" "$LABELS_FILE")
    color=$(yq -r ".[$i].color" "$LABELS_FILE")
    description=$(yq -r ".[$i].description" "$LABELS_FILE")

    # Look up existing label by name
    existing_color=$(grep -F "$name" "$EXISTING" | head -1 | cut -f2 || true)

    if [[ -n "$existing_color" ]]; then
      # Label exists — check if update needed
      if [[ "$existing_color" == "$color" ]]; then
        SKIPPED=$((SKIPPED + 1))
        continue
      fi
      if $DRY_RUN; then
        echo "  UPDATE: $name (color $existing_color → $color)"
        UPDATED=$((UPDATED + 1))
      else
        if gh label edit "$name" --repo "$ORG/$repo" --color "$color" --description "$description" &>/dev/null; then
          echo "  UPDATE: $name"
          UPDATED=$((UPDATED + 1))
        else
          echo "  ERROR updating: $name"
          ERRORS=$((ERRORS + 1))
        fi
      fi
    else
      # Label doesn't exist — create
      if $DRY_RUN; then
        echo "  CREATE: $name ($color)"
        CREATED=$((CREATED + 1))
      else
        if gh label create "$name" --repo "$ORG/$repo" --color "$color" --description "$description" &>/dev/null; then
          echo "  CREATE: $name"
          CREATED=$((CREATED + 1))
        else
          echo "  ERROR creating: $name"
          ERRORS=$((ERRORS + 1))
        fi
      fi
    fi
  done

  rm -f "$EXISTING"
  echo ""
done

echo "═══════════════════════════════════"
echo "Done. Created: $CREATED | Updated: $UPDATED | Skipped (no change): $SKIPPED | Errors: $ERRORS"
