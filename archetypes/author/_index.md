---
# display name
title: {{ .File.Path | path.Dir | path.Base | humanize | title }}

# is this the primary user of the site?
superuser: true

# organizations/affiliations
organizations:
  - name: Bioinformatics and Biostatistics STP
    url: https://www.crick.ac.uk/research/platforms-and-facilities/bioinformatics-and-biostatistics

# social/academic networking
# for available icons, see: https://sourcethemes.com/academic/docs/page-builder/#icons
#   for an email link, use "fas" icon pack, "envelope" icon, and a link in the
#   form "mailto:your-email@example.com" or "#contact" for contact widget.
social:
  - label: Send an email
    icon: envelope
    icon_pack: fas
    link: mailto:{{ .File.Path | path.Dir | path.Base | replaceRE "-" "." }}@crick.ac.uk?subject={{ getenv "LIMSID" }}
    display:
      header: true
      footer: true
  - label: GitHub
    icon: github-alt
    icon_pack: fab
    link: https://github.com/CrickBABS
    display:
      header: true
      footer: false
  - label: ORCID
    icon: orcid
    icon_pack: ai
    link: https://orcid.org/{{ getenv "ORCID" | default "0000-0003-1281-2658" }}
    display:
      header: true
      footer: false
---

<!-- hugo new --kind author authors/christopher-barrington -->
