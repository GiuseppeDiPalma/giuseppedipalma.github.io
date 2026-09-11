# My personal and only space on github and on web

## Coming soon "HOW TO"

Pandoc + Markdown + Script + HTML5 + CSS * VSCODE = ❤️


![Website](https://img.shields.io/website?label=Website%20Status&style=plastic&up_message=online&url=https%3A%2F%2Fgiuseppedp.page%2F) ![GitHub last commit](https://img.shields.io/github/last-commit/GiuseppeDiPalma/giuseppedipalma.github.io?label=Last%20update&style=plastic) ![GitHub repo size](https://img.shields.io/github/repo-size/GiuseppeDiPalma/giuseppedipalma.github.io?style=plastic) ![GitHub license](https://img.shields.io/github/license/GiuseppeDiPalma/giuseppedipalma.github.io?style=plastic)

### Next things to add at this readme

- [ ] Why I use this type of website;
- [ ] coming soon...

# How to build website

This website is a static website generated locally with Pandoc.

The source files are Markdown files, Pandoc HTML templates and YAML defaults:

- `index.md` + `template/index.html` + `defaults/params_index.yaml` generate `index.html`
- `sections/blog/posts/<article>.md` + `template/blogArticle/article.html` + `defaults/blogArticle/<article>.yaml` generate `sections/blog/final/<article>.html`
- `sections/curriculumVitae/cv.md` + `template/cv_page.html` + `defaults/cv.yaml` can generate `CV.html`, but this command is currently commented in `utils/build.sh`

Blog articles follow this convention:

- `sections/blog/posts/`: published Markdown articles compiled by the build script
- `sections/blog/drafts/`: draft articles, ignored by the build script
- `defaults/blogArticle/`: one YAML metadata file for each article, with the same basename as the Markdown file
- `sections/blog/final/`: generated HTML articles

## Requirements

- Bash
- Pandoc available in `PATH`

If Pandoc is installed in another path, use `PANDOC_BIN`:

```bash
PANDOC_BIN=/path/to/pandoc bash utils/build.sh
```

## Build all generated pages

```bash
bash utils/build.sh
```

Generated files are written back into the repository:

- `index.html`
- `sections/blog/final/*.html`

## Build one article

```bash
bash utils/test.sh testArticle
```

The argument is the article basename without `.md`.

## Create a new article

```bash
bash utils/new_article.sh "Titolo del mio articolo"
```

The script generates a dated slug and creates:

```text
sections/blog/posts/YYYY-MM-DD-titolo-del-mio-articolo.md
defaults/blogArticle/YYYY-MM-DD-titolo-del-mio-articolo.yaml
```

Then edit the Markdown file and build the article:

```bash
bash utils/test.sh YYYY-MM-DD-titolo-del-mio-articolo
```

To build everything, including the homepage:

```bash
bash utils/build.sh
```

## COME

1. Creo l'articolo con `bash utils/new_article.sh "Titolo del mio articolo"`
2. Scrivo il contenuto nel file Markdown creato in `sections/blog/posts/`
3. Se necessario, modifico i metadati nel file YAML creato in `defaults/blogArticle/`
4. Aggiungo manualmente il link dell'articolo in `defaults/params_index.yaml`, dentro `page.contents.articles`
5. Lancio `bash utils/build.sh`
6. Committo e pusho sorgenti e HTML generati

- Per apportare modifiche al template HTML degli articoli devo modificare `template/blogArticle/article.html`

## TO-DO

- Aggiungere TAG ad ogni articolo (abbellire le quote(>) in markdown con qualcosa lato css)
