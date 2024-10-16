#! /bin/env Rscript

## ---- parse-command-line-arguments

local({
     	description <- r"[Prepare a Cell Ranger ARC configuration files.]"

	# helper function to return object if it already exists
	`%?%` <- function(x, y) if(exists(deparse(substitute(x)))) x else y

	# make argument parser and groups
	parser   <- argparse::ArgumentParser(description=description)
	inputs   <- parser$add_argument_group('Input options')
	outputs  <- parser$add_argument_group('Output options')
	analysis <- parser$add_argument_group('Analysis options')

	# if running in batch mode, these will be required
 	is_required <- ! (interactive() | Sys.getenv('QUARTO_DOCUMENT_PATH') != '')

	# specify expected arguments
	## input arguments
	inputs$add_argument(
		'--fastq-path',
		default  = fastq_path %?% 'inputs/fastq/',
		help     = 'Path to directory that has a "<flow cell>/fastq/<library>.(...).fastq.gz" subdirectory structure. This is the expected structure provided by Genomics STP.',
		metavar  = 'inputs/fastq/')

	inputs$add_argument(
		'--library-metadata-csv',
		default  = library_metadata_csv %?% 'inputs/library-metadata.csv',
		help     = 'CSV file with "library", "sample" and "assay" variables. Assay should be one of "Gene Expression" or "Chromatin Accessibility" for each library. Sample should be a human-readable and directory-safe name for the sample from which the libraries were made.',
		metavar  = 'inputs/library-metadata.csv')

	## output arguments
	outputs$add_argument(
		'--outputs-path',
		default=outputs_path %?% 'outputs',
		help='Directory under which outputs will be written.',
		metavar='outputs/')

	outputs$add_argument(
		'--skip-writing-outputs',
		action='store_false',
		default=skip_writing_outputs %?% FALSE,
		help='Writing of output files can be skipped.')

	## analysis arguments

	## other arguments

	# get command line options. print help message and exit if -h or --help is provided
	parser$parse_args() |>
		(\(args) Map(dest=names(args), value=args, \(dest, value) {
			assign(x=dest, value=value, envir=globalenv())}))() -> args

	# print console messages
	gtools::script_file() |> basename() |> cli::cli_h1()
	cli::cli_h2('command line arguments')

	Map(n=names(args), v=args, \(n, v) cli::cli_alert_info('{.field {n}} = {.val {v}}')) |>
		invisible()})

## ---- post-a-message-to-separate-output

cli::cli_h2('log')

## ---- load-script-libraries

cli::cli_progress_step('loading required libraries')

suppressPackageStartupMessages({
	library(plyr)

	library(cli)
	library(dplyr)
	library(fs)
	library(magrittr)
	library(purrr)
	library(readr)
	library(stringr)
	library(tibble)
	library(tidyr)})

cli::cli_progress_done()

## ---- get-fastq-files-from-genomics

fastq_path |>
	path_real() |>
	list.files(
		full.names = TRUE) |>
	file.path('fastq') |>
	list.files(
		pattern    = '.*_R1_.*\\.fastq\\.gz',
		full.names = TRUE) ->
	fastq_paths

fastq_paths |>
	str_remove(
		pattern = '_S[0-9]+_L[0-9]+_R[1,2]_[0-9]+.fastq.gz$') |>
	enframe(
		name  = NULL,
		value = 'fastqs_library') |>
	transmute(
		fastqs  = dirname(fastqs_library),
		library = basename(fastqs_library)) |>
	distinct() ->
	library_paths

cli_alert_success('collected {length(fastq_paths)} (R1) fastq file{?s} from {.path {fastq_path}} for {nrow(library_paths)} librar{?y/ies}')

## ---- get-library-metadata

library_metadata_csv |>
	read_csv(
		progress       = FALSE,
		show_col_types = FALSE) ->
	library_metadata

cli_alert_success('read library metadata from {.file {library_metadata_csv}}')

## ---- get-sample-csv-content

library_paths |>
	left_join(
		y  = library_metadata,
		by = 'library') |>
	dlply(
		~sample,
		select,
			fastqs,
			sample=library,
			library_type=assay) ->
	sample_csv_content

cli_alert_success('joined fastq and library information together')

## ---- write-sample-csvs

if(skip_writing_outputs) {
	cli_alert_danger('{.code {"--skip-writing-outputs"}} was specified, output files will not be written!')
} else {
	# create the output path
	dir.create(path=outputs_path, recursive=TRUE, showWarnings=FALSE)

	Map(
		content = sample_csv_content,
		fname   = names(sample_csv_content),
		\(content, fname)
			path(outputs_path, fname, ext='csv') |>
				write_csv(x=content)) |>
 		invisible()

	cli_alert_success('written {length(sample_csv_content)} csv configuration file{?s} to {.path {outputs_path}}')
}
