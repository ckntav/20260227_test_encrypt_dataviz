#!/usr/bin/env bash
# =============================================================================
# deploy.sh — Encrypt & deploy the DDR vs MSI HTML explorer to GitHub Pages
#
# Usage:
#   ./deploy.sh /path/to/20260227_DDR_vs_MSI_status_TCGA.html
#
# What it does:
#   1. Encrypts the HTML with staticrypt (AES-256, password never stored)
#   2. Writes the result as index.html in this repo
#   3. Commits and pushes to GitHub Pages (main branch, root)
#
# First-time setup (one-off):
#   chmod +x deploy.sh
#   Go to GitHub → repo → Settings → Pages → Branch: main / folder: / (root)
# =============================================================================
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
HTML_SRC="${1:-}"

# ── Argument check ────────────────────────────────────────────────────────────
if [[ -z "$HTML_SRC" ]]; then
  echo "Usage: ./deploy.sh /path/to/20260227_DDR_vs_MSI_status_TCGA.html"
  exit 1
fi

if [[ ! -f "$HTML_SRC" ]]; then
  echo "Error: file not found: $HTML_SRC"
  exit 1
fi

# ── Password prompt (not echoed, never stored) ────────────────────────────────
echo ""
read -rsp "🔑  Enter page password (not echoed): " PASSWORD
echo ""
read -rsp "🔑  Confirm password: " PASSWORD2
echo ""

if [[ "$PASSWORD" != "$PASSWORD2" ]]; then
  echo "Error: passwords do not match."
  exit 1
fi

if [[ ${#PASSWORD} -lt 6 ]]; then
  echo "Error: password must be at least 6 characters."
  exit 1
fi

# ── Encrypt with staticrypt ───────────────────────────────────────────────────
# staticrypt v3 names the output file after the input file, so we copy the
# source to a temp file called "index.html" → output will be $REPO_DIR/index.html
echo "Encrypting..."
TMP_DIR=$(mktemp -d)
cp "$HTML_SRC" "$TMP_DIR/index.html"

npx --yes staticrypt "$TMP_DIR/index.html" \
  --password "$PASSWORD" \
  -d "$REPO_DIR" \
  --short \
  --template-color-primary  "#047857" \
  --template-color-secondary "#f0fdf4" \
  --template-title "DDR vs MSI – TCGA Explorer" \
  --template-instructions "Enter the password to access the explorer." \
  --template-button "Unlock"

rm -rf "$TMP_DIR"
unset PASSWORD PASSWORD2
echo "✓  index.html generated in $REPO_DIR"

# ── Commit & push ─────────────────────────────────────────────────────────────
cd "$REPO_DIR"
git add index.html
git diff --cached --quiet && echo "No changes to commit." && exit 0

STAMP=$(date '+%Y-%m-%d %H:%M')
git commit -m "Deploy: DDR vs MSI explorer ($STAMP)"
git push origin main

echo ""
echo "✓  Deployed to:"
echo "   https://ckntav.github.io/20260227_test_encrypt_dataviz/"
