## Syntax notes

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

::: {.callout-note collapse=true title="A descriptive title"}
Note that there are five types of callouts, including:
`note`, `warning`, `important`, `tip`, and `caution`.
:::
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

## Bugs

* code annotations: [Safari problem](https://github.com/quarto-dev/quarto-cli/issues/6387), switch to Chrome
