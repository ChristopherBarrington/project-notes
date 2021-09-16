# project-notes

produces websites to share analysis reports

[wowchemy getting started](https://wowchemy.com/docs/getting-started)

[wowchemy hugo modules](https://github.com/wowchemy/wowchemy-hugo-modules)

[an example site](https://github.com/rodrigoalcarazdelaosa/fisiquimicamente)

[getting started (HUGO)](https://gohugo.io/categories/getting-started)

[quick start (HUGO)](https://gohugo.io/getting-started/quick-start)

[managing blogdown (a basis for this repo/workflow)](https://drmowinckels.io/blog/2020-05-25-changing-you-blogdown-workflow)

[HUGO shortcode](https://gohugo.io/content-management/shortcodes)

## clone the repository

```bash
git clone && mkdir content
```

## conda setup

```bash
conda create # etc
# copy hugo binary
conda install python=3.9.7
pip3 install academic
```

### make an author

```bash
hugo new --kind author authors/christopher-barrington
```

__Note the lack of `.` in the name, it is interpreted as a file extension. Should be the first part of our crick email.__

### make the home page

```bash
TITLE=`ts get key=Scititle` hugo new --kind home home
cd content/home
renv_ln
Rscript -e 'knitr::knit("babs-information.Rmd")'
Rscript -e 'knitr::knit("project-information.Rmd")'
```

## make new content

```bash
hugo new --kind book new-book
hugo new --kind chapter new-book/new-chapter/index.Rmd

hugo new --kind docs new-docs
hugo new --kind doc new-docs/new-doc/index.Rmd
```

## callouts

```go
{{< callout [info,warning,notice,question,result,automated] >}}
Text in the callout.
{{< /callout >}}
```

## in-text icons

```go
{{< icon name="file-word" pack="fas" >}}
```

## render the website

```bash
HUGO_TITLE=`ts get key=Scititle` hugo
```

