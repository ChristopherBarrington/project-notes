#! /bin/env bash

#
# write a cell ranger multi configuration file for a multiplexed library
#
# FASTQ_PATH: path or symlink to the Genomics-structured FastQ data directory, eg the "primary_data" directory
# OUTPUTS: path into which data is written
# PROBE_SET: path or symlink to the probe set file
# REFERENCE: path or symlink to the reference index
# SAMPLE_SHEETS: path or symlink to a directory containing library csv sample sheets; these *must* have "sample_id" and "probe_barcode_ids" in the first two columns
#

## ---- get-realpaths-of-symlinks

if [[ -L $PROBE_SET ]]; then
	PROBE_SET=`readlink $PROBE_SET`
fi

if [[ -L $REFERENCE ]]; then
	REFERENCE=`readlink $REFERENCE`
fi

## ---- print-parameters

echo "FASTQ=$FASTQ"
echo "OUTPUTS=$OUTPUTS"
echo "PROBE_SET=$PROBE_SET"
echo "REFERENCE=$REFERENCE"
echo "SAMPLE_SHEETS=$SAMPLE_SHEETS"

## ---- make-output-path

mkdir --parents $OUTPUTS

## ---- write-configs-for-sample-sheets

for sample_sheet in $(find -L $SAMPLE_SHEETS -name '*.csv' | sort --version-sort); do
	library=`basename ${sample_sheet%.*}`

	echo "sample_sheet=$sample_sheet ; library=$library"

	cat > $OUTPUTS/$library.conf <<- CELL_RANGER_CONFIG
		[gene-expression]
		chemistry,auto
		probe-set,$PROBE_SET
		reference,$REFERENCE

		[libraries]
		fastq_id,fastqs,feature_types
		$(find -L $FASTQ/*/fastq -name "${library}_*.fastq.gz" -printf '%P,%h\n' \
		  | sed \
		  --regexp-extended \
		  --expression 's/_.+,/,/' \
		  --expression 's/$/,Gene Expression/' \
		  | sort --version-sort \
		  | uniq)

		[samples]
		sample_id,probe_barcode_ids
		$(cut --fields 1,2 --delimiter , $sample_sheet | \
		  tail --lines +2)
	CELL_RANGER_CONFIG
done
