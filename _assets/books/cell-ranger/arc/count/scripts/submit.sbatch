#! /usr/bin/bash

#
# run cell ranger arc on 10x multiome samples
#
# user parameters:
#
# OUTPUTS: root path for output data
# REFERENCE: path to a cell ranger arc reference index directory; if it is a sylink the link is dereferenced
# SLURM_ARRAY_TASK_ID: (optional) identifies a cell ranger arc configuration file, provided as a positional argument
# SLURM_CPUS_PER_TASK: (optional) number of cores to use on the local machine
# positional arguments 1-N (eg sbatch script.sbatch 1 2 3) are paths to cell ranger arc configuration files
#

## ---- define-slurm-parameters

#SBATCH --array 1
#SBATCH --cpus-per-task 48
#SBATCH --job-name cell-ranger-arc-count
#SBATCH --mem 380G
#SBATCH --ntasks 1
#SBATCH --output slurm-%A_%a.out
#SBATCH --partition ncpu
#SBATCH --time 2-00:00

## ---- define-parameters

sample_configuration_csv=${!SLURM_ARRAY_TASK_ID:-missing}
sample_name=`basename ${sample_configuration_csv%.csv}`

## ---- check-and-read-reference-index-symlink

if [[ -L $REFERENCE ]]; then
	REFERENCE=`readlink --canonicalize-existing $REFERENCE`
fi

## ---- print-variables

echo "sample_configuration_csv=$sample_configuration_csv"
echo "REFERENCE=$REFERENCE"
echo "OUTPUTS=$OUTPUTS"
echo "sample_name=$sample_name"
echo "SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID"
echo "SLURM_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK"

## ---- run-cell-ranger-arc-count

module load CellRanger-ARC/2.0.1

cellranger-arc count \
--disable-ui \
--id $sample_name \
--reference $REFERENCE \
--libraries $sample_configuration_csv \
--jobmode local \
--localcores $SLURM_CPUS_PER_TASK \
--localmem $(($SLURM_CPUS_PER_TASK * 7))

## ---- move-output-to-output-directory

data_path=$OUTPUTS/data
reports_path=$OUTPUTS/reports/$sample_name

# copy reports
atac_web_summary=$sample_name/SC_ATAC_GEX_COUNTER_CS/SC_ATAC_GEX_COUNTER/_SC_ATAC_REPORTER/CREATE_WEBSUMMARY/fork0/files/web_summary.html
gex_web_summary=$sample_name/SC_ATAC_GEX_COUNTER_CS/SC_ATAC_GEX_COUNTER/GEX_SUMMARIZE_REPORTS/fork0/files/web_summary.html

mkdir --parents $reports_path \
&& cp $sample_name/outs/web_summary.html $reports_path/joint_summary.html \
&& cp $atac_web_summary $reports_path/atac_summary.html \
&& cp $gex_web_summary $reports_path/gex_summary.html

# move cell ranger arc output
mkdir --parents $data_path \
&& mv $sample_name $data_path
