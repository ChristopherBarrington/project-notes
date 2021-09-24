---
title: {{ default "scviewer" (getenv "TITLE") }}
weight: {{ default 99 (getenv "WEIGHT") }}

categories:

tags:

authors:
  - christopher-barrington

date: {{ now.Format "2006-01-02" }}
created: {{ now.Format "2006-01-02" }}
---

<!-- TITLE='SCViewer' WEIGHT=99 hugo new --kind scviewer scviewer  -->

<!-- loads the app from static directory -->
