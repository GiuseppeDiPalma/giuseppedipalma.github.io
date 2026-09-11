#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -eq 0 ]; then
  echo "Usage: bash new_article.sh \"Article title\"" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

TITLE="$*"
ARTICLE_DATE="${ARTICLE_DATE:-$(date +%F)}"
SLUG="$(printf '%s' "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"

if [ -z "$SLUG" ]; then
  echo "Error: unable to generate a slug from title: $TITLE" >&2
  exit 1
fi

ARTICLE_NAME="$ARTICLE_DATE-$SLUG"
POSTS_DIR="$ROOT_DIR/sections/blog/posts"
DEFAULTS_DIR="$ROOT_DIR/defaults/blogArticle"
POST_FILE="$POSTS_DIR/$ARTICLE_NAME.md"
DEFAULTS_FILE="$DEFAULTS_DIR/$ARTICLE_NAME.yaml"
YAML_TITLE="$(printf '%s' "$TITLE" | sed "s/'/''/g")"

if [ -e "$POST_FILE" ] || [ -e "$DEFAULTS_FILE" ]; then
  echo "Error: article already exists: $ARTICLE_NAME" >&2
  exit 1
fi

mkdir -p "$POSTS_DIR" "$DEFAULTS_DIR" "$ROOT_DIR/sections/blog/final"

cat > "$POST_FILE" <<EOF
# $TITLE

----------

> #tag

Write article content here.
EOF

cat > "$DEFAULTS_FILE" <<EOF
---
metadata:
  title: '$YAML_TITLE'
  author:
    - Giuseppe Di Palma
  title-prefix: ">_ gdp: "
  page:
    resources:
      css:
        - "../../../css/index.css"
        - "../../../css/article.css"
        - "../../../css/hr.css"
        - "../../../css/collapse.css"
      js:
        - "../../../js/dynamics.js"
        - "../../../js/tinycolor.js"
        - "../../../js/mv.es5.js"
    contents:
      contacts:
        name: Giuseppe Di Palma
        shortdescription: Cloud Solutions Architect
        twitter: https://twitter.com/DiGiuseppePalma
        email: dipalmagiuseppe1@gmail.com
        linkedin: https://www.linkedin.com/in/dplmgspp/
        github: https://github.com/GiuseppeDiPalma
EOF

echo "Created article:"
echo "- ${POST_FILE#$ROOT_DIR/}"
echo "- ${DEFAULTS_FILE#$ROOT_DIR/}"
echo
echo "Build it with:"
echo "  cd utils"
echo "  bash test.sh $ARTICLE_NAME"
