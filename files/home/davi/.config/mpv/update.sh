#!/usr/bin/env bash
# Update every script submodule to the latest commit of its upstream default branch.
# Review with `git diff --submodule=log`, then commit.
set -euo pipefail
cd "$(dirname "$0")"

git submodule sync --quiet
git submodule update --init --remote --recursive

git submodule foreach --quiet 'echo "$name: $(git log -1 --format="%h %ad %s" --date=short)"'

# scripts/autosub.lua is a customized copy (settings are hardcoded in it), not a submodule.
# Bump AUTOSUB_BASE after merging upstream changes into it by hand.
AUTOSUB_REPO=https://github.com/davidde/mpv-autosub
AUTOSUB_BASE=35115355bd339681f97d067538356c29e5b14afa
autosub_head=$(git ls-remote "$AUTOSUB_REPO" HEAD | cut -f1)
if [[ $autosub_head != "$AUTOSUB_BASE" ]]; then
    echo "scripts/autosub.lua: upstream has new commits: $AUTOSUB_REPO/compare/$AUTOSUB_BASE...$autosub_head"
else
    echo "scripts/autosub.lua: up to date with upstream"
fi

echo
git --no-pager diff --submodule=log
