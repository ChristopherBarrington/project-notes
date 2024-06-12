## Syntax notes

### code chunks
```
{.bash filename='Create Singularity image'}
singularity build \
tb-profiler_1.sif \
docker://quay.io/biocontainers/tb-profiler:5.0.1--pyhdfd78af_1
```

```
{bash create-singularity}
#| code-summary: Create Singularity image
#| eval: false

singularity build \
tb-profiler_1.sif \
docker://quay.io/biocontainers/tb-profiler:5.0.1--pyhdfd78af_1
```

### content visibility

```
::: {.content-visible when-profile="dev"}
This content will only appear in the dev version.
:::

::: {.content-visible when-profile="internal"}
This content will only appear in the internal version.
:::

::: {.content-visible when-profile="external"}
This content will only appear in the external version.
:::
```

### [callouts](https://quarto.org/docs/authoring/callouts.html)

```
::: {.callout-note collapse=true title="A descriptive title"}
There are five types of callouts, including:
`note`, `warning`, `important`, `tip`, and `caution`.
:::

::: {.callout-tip title="Tip with Title"}
This is a callout with a title.
:::
```

You can set the callout appearance either globally in the document (or project yaml) or in the div definition:
```yaml
callout-appearance: simple
```

```
::: {.callout-note appearance='simple'}
## Pay Attention
Using callouts is an effective way to highlight content that your reader give special consideration or attention.
:::
```

### [citations](https://quarto.org/docs/authoring/footnotes-and-citations.html)

The configuration file points to a bibliography in `_configs/projects/bibliography.bib`. This can be created for a project (specifically) or linked to a project-independent collection of references.

```bash
ln --symbolic /nemo/stp/babs/working/barrinc/projects/christopher.barrington/templates/bibliography.bib _configs/project/bibliography.bib
```

```
@key1          # Author (2024)
[@key1]        # (Author 2023)
[@key1; @key2]
@{key1}
```

## Extensions

### [academicicons](https://github.com/schochastics/academicons)

Adds icons for academic resources

```bash
quarto add schochastics/academicons
```

```markdown
{{< ai arxiv >}}
```

### [downloadthis](https://github.com/shafayetShafee/downloadthis)

Adds a download button shortcode with styling options

```bash
quarto add shafayetShafee/downloadthis
```

```markdown
{{< downloadthis files/quarto.png >}}
```

### [embedpdf](https://github.com/jmgirard/embedpdf)

Embedding a pdf into html

```bash
quarto add jmgirard/embedpdf
```

```markdown
{{< pdf dummy.pdf >}}
```

### [fontawesome](https://github.com/quarto-ext/fontawesome)

Add support for Font Awesome 6

```bash
quarto add quarto-ext/fontawesome
```

```markdown
{{< fa thumbs-up >}} 
```

### [material-icons](https://github.com/shafayetShafee/material-icons)

Include icon set from [Google Material Design Icons](https://fonts.google.com/icons?icon.set=Material+Icons)

```bash
quarto add shafayetShafee/material-icons
```

```markdown
{{< mi verified_user >}}
```

### [search-replace](https://github.com/ute/search-replace)

Allows a defined dictionary of key/values that will be substituted when rendered. The dictionary is in the document metadata so can be applied project-wide.

```bash
quarto add ute/search-replace
```

```yaml
---
filters:
  - search-replace
search-replace:
  +quarto: "[Quarto](https://quarto.org)"
  +qurl  : https://quarto.org/docs
  +forml : $\alpha * \beta = \gamma$
  +pyth  : "*Pythagoras' theorem*: $a^2 + b^2 = \\dots$"
  .doo   : "- doodledoo - "
  +dab   : "**dab**"
  "!doa" : "`duaaah`"
  +br    : <br>\newline
---  
```

```markdown
+quarto allows us to write beautiful texts 
about +pyth or similar complicated formulas (e.g. +forml), 
and to [create our *own* filters](+qurl/extensions/filters.html). +br
Even filters that replace text:+br
.doo+dab+dab+dab!doa, +dab!doa!
```

## [project citation](https://quarto.org/docs/reference/metadata/citation.html)

Once published, a citation can be added to the homepage's `index.{qR}md`. This will add a citation field to an appnedix-style div on the home page. The markdown can be exported from bibdesk: right-click -> copy using template -> quarto-citation-metadata

```yaml
citation:
  type: article-journal
  container-title: ACM Transactions on Embedded Computing Systems
  volume: 21
  issue: 2
  issued: 2022-03
  issn: 1539-9087
  doi: 10.1145/3514174
```

## Bugs

* code annotations: [Safari problem](https://github.com/quarto-dev/quarto-cli/issues/6387), switch to Chrome
