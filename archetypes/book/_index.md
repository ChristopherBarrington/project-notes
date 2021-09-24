---
title: {{ default (.File.Path | path.Dir | path.Base | replaceRE "^20\\d+-\\d+-\\d+-" "" | humanize | title) (getenv "TITLE") }}
weight: 1

categories:

tags:

authors:
  - christopher-barrington

date: {{ now.Format "2006-01-02" }}
created: {{ now.Format "2006-01-02" }}

type: book
toc: false
draft: false
---

Anything here is included in the summary.

<!--more-->
