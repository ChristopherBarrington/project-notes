---
# display name
title: BABS

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
  - label: GitHub
    icon: github-alt
    icon_pack: fab
    link: https://github.com/BABS-STP/{{ getenv "BABS_HASH" | default "" }}
    display:
      header: true
      footer: false
---

<!-- BABS_HASH=`ts get key=Hash` hugo new --kind authors authors -->
