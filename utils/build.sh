#!/bin/bash

echo "Build index"
/home/peppe/pandoc-3.5/bin/pandoc ../index.md -s -f gfm -t html5 --template=../template/index.html --defaults=../defaults/params_index.yaml --output ../index.html

echo "Build Articles"
pandoc ../sections/blog/testArticle.md \
-f markdown -t html \
--template=../template/blogArticle/article.html \
--defaults=../defaults/blogArticle/firstTestArticle.yaml \
--highlight-style=breezedark \
--output ../sections/blog/final/testArticle.html
# echo "Build CV page"
# pandoc ../sections/curriculumVitae/cv.md \
# -f markdown \
# -t html --template=../template/cv_page.html \
# --defaults=../defaults/cv.yaml \
# --highlight-style=breezedark \
# --output ../CV.html

# Usare questo per far compilare sulla base di un file md
# pandoc ../articles/web-resources-31-03-21.md -f markdown -t html --template=../template/article.html --defaults=../defaults/cv.yaml --highlight-style=breezedark --output ../articles/CV.html