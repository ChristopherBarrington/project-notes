#! /bin/env/Rscript

#
# write cell ranger arc configuration csv files
#
# user parameters:
#
# fastq_path: root path under which fastq files can be found
# library_metadata: csv with expected variables for each library
# outputs: directory into which data is written
#


## ---- define-expected-environment-variable-parameters

env_vars <- c('fastq_path', 'library_metadata', 'outputs')

## ---- collect-parameters

collect_parameter <- function(x)
	Sys.getenv(x=x, unset='missing') |>
		readr::parse_guess() |>
		assign(x=x, envir=globalenv()) |>
		(\(X) stringr::str_glue('{x}: {X}'))() |>
		usethis::ui_info()

plyr::l_ply(env_vars, collect_parameter)

## ---- load-script-libraries

suppressPackageStartupMessages({
	library(plyr)

	library(dplyr)
	library(fs)
	library(magrittr)
	library(purrr)
	library(readr)
	library(stringr)
	library(tibble)
	library(tidyr)})

## ---- get-fastq-files-from-genomics

fastq_path %<>%
	path_real() %>%
	list.files(full.names=TRUE) %>%
	file.path('fastq') %>%
	list.files(pattern='*_R1_*', full.names=TRUE) %>%
	str_remove('_S\\d+_L\\d+_R\\d_\\d+.fastq.gz$') %>%
	enframe(name=NULL, value='fullpath') %>%
	extract(col=fullpath, regex='^(.+)/(.+)$', into=c('fastqs', 'sample'), remove=TRUE) %>%
	distinct()

## ---- get-library-metadata

library_metadata %<>%
	read_delim(progress=FALSE, show_col_types=FALSE)

## ---- get-sample-csv-content

data.frame(assay=c('GEX','ATAC'),
           library_type=c('Gene Expression', 'Chromatin Accessibility')) |>
	right_join(y=library_metadata, by='assay') |>
	left_join(y=fastq_path, by='sample') |>
	dlply(~name, select, fastqs, sample, library_type) -> sample_csv_content

## ---- write-sample-csvs

dir.create(path=outputs, recursive=TRUE, showWarnings=FALSE)

Map(content=sample_csv_content, fname=names(sample_csv_content), \(content, fname) path(outputs, fname, ext='csv') |> write_csv(x=content)) |>
	invisible()
