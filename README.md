# project-notes

produces websites to share analysis reports

## clone the repository

```bash
git clone
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

## render the website

```bash
HUGO_TITLE=`ts get key=Scititle` hugo
```

