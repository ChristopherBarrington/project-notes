---
title: {{ default (.File.Path | path.Dir | path.Base | replaceRE "^20\\d+-\\d+-\\d+-" "" | humanize | title) (getenv "TITLE") }}
weight:

categories:
tags:

authors:
  - christopher-barrington

date: {{ now.Format "2006-01-02" }}
created: {{ now.Format "2006-01-02" }}

type: docs
toc: false
draft: false
---

{{ default "<!-- Anything here is included in the summary. -->" (getenv "SUMMARY") }}

<!--more-->
