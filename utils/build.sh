#!/bin/bash

echo "Build index"
pandoc ../index.md -s -f gfm -t html5 --template=../template/index.html --defaults=../defaults/params_index.yaml --output ../index.html

echo "Build CV page"
pandoc ../curriculumVitae/cv.md -f markdown -t html --template=../template/cv_page.html --defaults=../defaults/cv.yaml --highlight-style=breezedark --output ../CV.html

# Usare questo per far compilare sulla base di un file md
# pandoc ../articles/web-resources-31-03-21.md -f markdown -t html --template=../template/article.html --defaults=../defaults/cv.yaml --highlight-style=breezedark --output ../articles/CV.html