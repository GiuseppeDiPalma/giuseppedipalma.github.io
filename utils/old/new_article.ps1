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
    title-prefix: ">_ gdp: "
    page:
      resources:
        css:
          - "../css/index.css"
          - "../css/article.css"
          - "../css/hr.css"
        js:
          - "../js/dynamics.js"
          - "../js/tinycolor.js"
          - "../js/mv.es5.js"
      contents:
        contacts:
          name: Giuseppe Di Palma
          shortdescription: System Engineer & Software Development
          twitter: https://twitter.com/DiGiuseppePalma
          email: dipalmagiuseppe1@gmail.com
          linkedin: https://www.linkedin.com/in/dplmgspp/
          github: https://github.com/GiuseppeDiPalma
"@

  # Generates the new article UUID
  # $uuid_article = [guid]::NewGuid().Guid
  # Generates article name

  $dateArticle = Get-Date -Format "dd-MM-yy"
  $article_name = $ArticleName +"-"+ $dateArticle
  $article_link = ".\articles\"+$article_name+".html"

  # Generated link to upload in params_index.yaml
  Write-Host "The new article have this name: "$article_name
  # Generated link to upload in params_index.yaml
  Write-Host "The new article have this link: "$article_link

  # Creates the params article file
  $article_params_template | Out-File -Encoding "UTF8" ..\defaults\params_$article_name.yaml
  # Creates the article and append the title
  "# $($article_name)" | Out-File -Encoding "UTF8" ..\articles\$article_name.md
}

New-Article -ArticleName $args[0]