---
# An instance of the Hero widget.
# Documentation: https://wowchemy.com/docs/page-builder/
widget: hero

# Activate this widget? true/false
active: true

# This file represents a page section.
headless: true

# Order that this section appears on the page.
weight: 11

title: {{ getenv "TITLE" | default "A BABS project" | replaceRE "\\(\\d+\\) " ""}}

hero_media:

design:
  background:
    gradient_start: '#4565AE'
    gradient_end: '#94CEF2'
    gradient_angle: 90
    text_color_light: true
  spacing:
    padding: ["5px", "0px", "5px", "0px"]
---
