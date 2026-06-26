#!/usr/bin/env bash
# Publikuje strony legal na GitHub Pages (repo: lonter100/bityai-legal)
set -euo pipefail
cd "$(dirname "$0")"

USER="${GITHUB_USER:-lonter100}"
REPO="bityai-legal"

if ! gh auth status >/dev/null 2>&1; then
  echo "Zaloguj się do GitHub:"
  gh auth login -h github.com -p https -w
fi

touch .nojekyll

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  git init -b main
  git add .
  git commit -m "BityAi legal pages"
fi

if git remote get-url origin >/dev/null 2>&1; then
  git push -u origin main
else
  gh repo create "$REPO" --public --source=. --remote=origin --push \
    --description "BityAi — privacy policy & terms for TikTok Developer"
fi

# GitHub Pages z gałęzi main / root
gh api "repos/${USER}/${REPO}/pages" -X POST \
  -f build_type=legacy \
  -f source[branch]=main \
  -f source[path]=/ 2>/dev/null || \
gh api "repos/${USER}/${REPO}/pages" -X PUT \
  -f build_type=legacy \
  -f source[branch]=main \
  -f source[path]=/

URL="https://${USER}.github.io/${REPO}/"
echo ""
echo "✅ GitHub Pages: $URL"
echo "   Privacy:    ${URL}privacy.html"
echo "   Terms:      ${URL}terms.html"
echo ""
echo "Wklej w TikTok Developer → App details."
