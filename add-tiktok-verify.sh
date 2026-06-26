#!/usr/bin/env bash
# Wgraj plik weryfikacyjny TikTok (URL properties) i opublikuj na GitHub Pages.
set -euo pipefail
cd "$(dirname "$0")"

if [ $# -lt 1 ]; then
  echo "Użycie: $0 <plik-pobrany-z-tiktok>"
  echo "Przykład: $0 tiktok-verify-abc123.txt"
  exit 1
fi

FILE="$1"
if [ ! -f "$FILE" ]; then
  echo "Brak pliku: $FILE"
  exit 1
fi

cp "$FILE" "./$(basename "$FILE")"
git add "./$(basename "$FILE")"
git -c user.name="BityAi" -c user.email="bityai@users.noreply.github.com" \
  commit -m "Add TikTok URL verification file"
git push origin main

echo "✅ Plik dostępny pod:"
echo "   https://lonter100.github.io/bityai-legal/$(basename "$FILE")"
echo "Wróć do TikTok → URL properties → Verify"
