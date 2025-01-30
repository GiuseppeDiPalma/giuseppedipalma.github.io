#!/bin/bash

echo "Build test.sh"
pandoc ../sections/blog/testArticle.md \
-f markdown -t html \
--template=../template/blogArticle/article.html \
--defaults=../defaults/blogArticle/firstTestArticle.yaml \
--highlight-style=breezedark \
--output ../sections/blog/final/testArticle.html