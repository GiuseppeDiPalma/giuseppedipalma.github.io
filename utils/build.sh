#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PANDOC_BIN="${PANDOC_BIN:-pandoc}"

POSTS_DIR="$ROOT_DIR/sections/blog/posts"
OUTPUT_DIR="$ROOT_DIR/sections/blog/final"
DEFAULTS_DIR="$ROOT_DIR/defaults/blogArticle"

if ! command -v "$PANDOC_BIN" >/dev/null 2>&1; then
  echo "Error: Pandoc not found. Install pandoc or set PANDOC_BIN=/path/to/pandoc." >&2
  exit 1
fi

build_index() {
  echo "Build index"
  "$PANDOC_BIN" "$ROOT_DIR/index.md" \
    -s -f gfm -t html5 \
    --template="$ROOT_DIR/template/index.html" \
    --defaults="$ROOT_DIR/defaults/params_index.yaml" \
    --output "$ROOT_DIR/index.html"
}

build_articles() {
  mkdir -p "$OUTPUT_DIR"

  shopt -s nullglob
  local posts=("$POSTS_DIR"/*.md)
  shopt -u nullglob

  if [ "${#posts[@]}" -eq 0 ]; then
    echo "No published articles found in $POSTS_DIR"
    return
  fi

  echo "Build articles"
  for post in "${posts[@]}"; do
    local article_name
    local defaults_file
    local output_file

    article_name="$(basename "$post" .md)"
    defaults_file="$DEFAULTS_DIR/$article_name.yaml"
    output_file="$OUTPUT_DIR/$article_name.html"

    if [ ! -f "$defaults_file" ]; then
      echo "Error: missing defaults file for article '$article_name': $defaults_file" >&2
      exit 1
    fi

    echo "- $article_name"
    "$PANDOC_BIN" "$post" \
      -f markdown -t html \
      --template="$ROOT_DIR/template/blogArticle/article.html" \
      --defaults="$defaults_file" \
      --highlight-style=breezedark \
      --output "$output_file"
  done
}

build_index
build_articles
