#! /usr/bin/bash

#
# create cell ranger index in merged genome mode (not barnyard)
#
# CELL_RANGER_MODULE: module passed to lmod providing cell ranger mkref
# FASTA: path to fasta files
# GENES: path to gtf files
# GENOME: unique and directory-safe genome name
# OUTPUT: path to the output reference index
# VERSION: reference version string
#

#SBATCH --cpus-per-task 16
#SBATCH --job-name cell-ranger-mkref
#SBATCH --mem 120G
#SBATCH --output slurm-%A.out
#SBATCH --partition ncpu
#SBATCH --time 1-00:00

## ---- collect-parameters

cell_ranger_module=${CELL_RANGER_MODULE:-CellRanger/8.0.0}
fasta_path=${FASTA:-inputs/dna}
genes_path=${GENES:-inputs/features}
genome_name=${GENOME:-new_genome}
nthreads=${SLURM_CPUS_PER_TASK:-4}
output_path=${OUTPUT:-outputs/$genome_name}
ref_version=${VERSION:-version1}
tmp_path=${TEMP_PATH:-etc}

## ---- show-parameters

echo "# provided parameters:"
echo "CELL_RANGER_MODULE=$CELL_RANGER_MODULE"
echo "FASTA=$FASTA"
echo "GENES=$GENES"
echo "GENOME=$GENOME"
echo "OUTPUT=$OUTPUT"
echo "VERSION=$VERSION"
echo ""
echo "# script parameters:"
echo "cell_ranger_module=$cell_ranger_module"
echo "fasta_path=$fasta_path"
echo "genes_path=$genes_path"
echo "genome_name=$genome_name"
echo "nthreads=$nthreads"
echo "output_path=$output_path"
echo "ref_version=$ref_version"
echo "tmp_path=$tmp_path"

## ---- merge-input-files

mkdir --parents $tmp_path

cat $fasta_path/*.{fa,fasta}.gz \
| gunzip --to-stdout \
> $tmp_path/fasta \

cat \
<(head --lines 20 --silent $genes_path/*.gtf | sed --silent '/^#/p') \
<(sed '/^#/d' $genes_path/*.gtf) \
> $tmp_path/gtf \

## ---- prepare-output-directories
rm --force --recursive $output_path && mkdir --parents $_ 
rm --force __mkref_*.mro

## ---- run-cell-ranger-mkref

# load cell ranger
module load $cell_ranger_module || exit

# run cell ranger mkref
cellranger mkref \
--genome $genome_name \
--fasta $tmp_path/fasta \
--genes $tmp_path/gtf \
--nthreads $nthreads \
--memgb $(($nthreads * 7)) \
--jobmode local \
--ref-version $ref_version \
--localcores $nthreads \
--localmem $(($nthreads * 7)) \
--output-dir $output_path \
--disable-ui
