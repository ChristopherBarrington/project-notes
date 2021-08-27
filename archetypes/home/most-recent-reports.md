---
# a widget to show the most recent `type=='docs'` reports
# ranked by the `date` parameter of the yaml front matter
# cannot get `type=='docs' | type=='book'` to work ...

widget: pages
headless: true # this file represents a page section.
weight: 31
active: true

# title and subtitle of the widget
title: Recently added
subtitle: _Most recently updated analysis reports_

# widget content
content:
  # page type to display. e.g. post, event, or publication.
  page_type: docs

  # choose how much pages you would like to display (0 = all pages)
  count: 3

  # choose how many pages you would like to offset by
  offset: 0

  # page order. descending (desc) or ascending (asc) date.
  order: desc

  # optionally filter posts by a taxonomy term.
  filters:
    tag: ''
    category: ''
    publication_type: ''
    exclude_featured: false
    exclude_past: false
    exclude_future: false

# widget design
design:
  # https://wowchemy.com/docs/getting-started/page-builder/#view
  # toggle between the various page layout types.
  #   1 = list
  #   2 = compact
  #   3 = card
  #   4 = citation (publication only)
  #   5 = showcase (large images), only available for projects
  view: 2

  # https://wowchemy.com/docs/getting-started/page-builder/#columns
  columns: '2'

  # https://wowchemy.com/docs/getting-started/page-builder/#background
  # add a gradient background
  # text_color: true=light, false=dark, or remove for the dynamic theme color
  # background:
    # gradient_start: '#4565AE'
    # gradient_end: '#94CEF2'
    # gradient_angle: 90
    # text_color_light: true

  # https://wowchemy.com/docs/getting-started/page-builder/#spacing
  spacing:
    # Customize the section spacing. Order is top, right, bottom, left.
    padding: ["20px", "0px", "20px", "0px"]

# https://wowchemy.com/docs/getting-started/page-builder/#style
css_style: ''
css_class: ''
---
