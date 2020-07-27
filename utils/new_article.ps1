function New-Article {
  <#
    .SYNOPSIS
        Generates a new article
    .DESCRIPTION
        This function generate new article structure with parameters and markdown file structure.
        Every new article will be identified with an unique UUID.
    .PARAMETER ArticleTitle
        The new article title
    .OUTPUTS
        The markdown file is generated inside the "articles" folder; the parameters file is generated inside the defaults file
    .EXAMPLE
        New-Article -ArticleTitle "My new article title"
    #>
  param(
    [Parameter(Mandatory=$true)]
    [string]$ArticleName
  )
  $article_params_template = @"
---
  metadata:
    title: $ArticleName
    author:
    - Giuseppe Di Palma
    title-prefix: ">_GDP  "
    page:
      resources:
        css:
          - "../css/index.css"
          - "../css/article.css"
        js:
          - "../js/tinycolor.js"
      contents:
        contacts:
          name: Giuseppe Di Palma
          shortdescription: System Engineer & Software Development
          twitter: '#'
          email: dipalmagiuseppe1@gmail.com
"@

  # Generates the new article UUID
  $uuid_article = [guid]::NewGuid().Guid
  # Creates the params article file
  $article_params_template | Out-File -Encoding "UTF8" ..\defaults\params_$uuid_article.yaml
  # Creates the article and append the title
  "# $($ArticleName)" | Out-File -Encoding "UTF8" ..\articles\$uuid_article.md
}

New-Article -ArticleName $args[0]