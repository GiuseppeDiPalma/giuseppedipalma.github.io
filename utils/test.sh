#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PANDOC_BIN="${PANDOC_BIN:-pandoc}"

ARTICLE_NAME="${1:-testArticle}"
ARTICLE_NAME="$(basename "${ARTICLE_NAME%.md}")"

POST_FILE="$ROOT_DIR/sections/blog/posts/$ARTICLE_NAME.md"
DEFAULTS_FILE="$ROOT_DIR/defaults/blogArticle/$ARTICLE_NAME.yaml"
OUTPUT_FILE="$ROOT_DIR/sections/blog/final/$ARTICLE_NAME.html"

if ! command -v "$PANDOC_BIN" >/dev/null 2>&1; then
  echo "Error: Pandoc not found. Install pandoc or set PANDOC_BIN=/path/to/pandoc." >&2
  exit 1
fi

if [ ! -f "$POST_FILE" ]; then
  echo "Error: article not found: $POST_FILE" >&2
  exit 1
fi

if [ ! -f "$DEFAULTS_FILE" ]; then
  echo "Error: defaults file not found: $DEFAULTS_FILE" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"

echo "Build article: $ARTICLE_NAME"
"$PANDOC_BIN" "$POST_FILE" \
  -f markdown -t html \
  --template="$ROOT_DIR/template/blogArticle/article.html" \
  --defaults="$DEFAULTS_FILE" \
  --highlight-style=breezedark \
  --output "$OUTPUT_FILE"
