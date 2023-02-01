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
conda create --no-default-packages # etc
# copy hugo binary
conda install python=3.9.7
pip3 install academic
```

## make an author

First make the authors directory

```bash
BABS_HASH=`ts get key=Hash` hugo new --kind authors authors
```

Then make an author

```bash
ORCID=0000-0003-1281-2658 LIMSID=`ts get key=Lims` hugo new --kind author authors/christopher-barrington
```

__Note the lack of `.` in the name, it is interpreted as a file extension. Should be the first part of our crick email.__

## make a bibliography

```bash
hugo new --kind bibliography publication
````

## make the home page

```bash
TITLE=`ts get key=Scititle` hugo new --kind home home
(cd content/home && renv_ln)
```

```bash
Rscript -e 'knitr::knit("babs-information.Rmd")'
Rscript -e 'knitr::knit("project-background.Rmd")'
```
## make new content

```bash
hugo new --kind book new-book
hugo new --kind chapter new-book/new-chapter/index.Rmd

hugo new --kind docs new-docs
hugo new --kind doc new-docs/new-doc/index.Rmd
```
### project data section

```bash
hugo new --kind docs project-data
hugo new --kind create-project-data project-data/define-project-parameters/index.Rmd
````
### callouts

```go
{{< callout [info,warning,notice,question,result,automated] >}}
Text in the callout.
{{< /callout >}}
```

### in-text icons

```go
{{< icon name="file-word" pack="fas" >}}
```

## render the website

```bash
HUGO_TITLE=`ts get key=Scititle` hugo
```
