#! /bin/env bash

#
# run cellranger multi on multiplexed samples
#
#
# OUTPUTS: root path for output data
# SLURM_ARRAY_TASK_ID: (optional) identifies a library configuration file, provided as a positional argument
# SLURM_CPUS_PER_TASK: (optional) number of cores to use on the local machine
# positional arguments 1-N (eg sbatch count.sbatch 1 2 3) are paths to library configuration files
#

#SBATCH --array 1
#SBATCH --cpus-per-task 16
#SBATCH --job-name cell-ranger-multi
#SBATCH --mem 120G
#SBATCH --output slurm-%A_%a.out
#SBATCH --partition ncpu
#SBATCH --time 2-00:00

## ---- define-parameters

config_path=${!SLURM_ARRAY_TASK_ID:-missing}
config_file=`basename $config_path`

library=${config_file%.csv}
output_path=$OUTPUTS/$library

## ---- check-and-read-reference-index-symlink

if [[ -L $REFERENCE ]]; then
	REFERENCE=`readlink --canonicalize-existing $REFERENCE`
fi

## ---- print-variables

echo "OUTPUTS=$OUTPUTS"
echo "SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID"
echo "SLURM_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK"
echo "config_path=$config_path"
echo "config_file=$config_file"
echo "library=$library"
echo "output_path=$output_path"

## ----load-cell-ranger

module load CellRanger/8.0.0

## ---- prepare-output-directories

rm --force --recursive $output_path && mkdir --parents $_
rm --force __$config.mro

## ---- run-cell-ranger-multi

cellranger multi \
--csv $config_path \
--description "$config" \
--disable-ui \
--id $config \
--jobmode local \
--localcores $SLURM_CPUS_PER_TASK \
--localmem $(($SLURM_CPUS_PER_TASK * 7)) \
--output-dir $output_path
