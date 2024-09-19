#! /bin/env bash

#
# merge a reference and custom probe set
#
# CUSTOM_GENOME_NAME: name of custom probe set genome
# CUSTOM_GENOME_VERSION: version of custom probe set genome
# CUSTOM_PANEL_NAME: name of custom probe set panel
# CUSTOM_PROBE_SET: custom probe set file to be added to the reference
# OUTPUT: file to which the merged probe set is written
# REFERENCE_PROBE_SET: probe set file to use as the reference
#

## ---- remove-exising-output-file

rm --force $OUTPUT
mkdir --parents $OUTPUT && rmdir $_

## ---- cat-reference-and-custom-probe-sets

cat \
<(sed --regexp-extended '/^(#|gene_id,)/!d' $REFERENCE_PROBE_SET) \
<(sed --regexp-extended --expression '/^(#|gene_id,)/d' $REFERENCE_PROBE_SET $CUSTOM_PROBE_SET) \
| sed \
--expression "/#panel_name=/ s/\$/ + $CUSTOM_PANEL_NAME/" \
--expression '/#panel_type=/ s/$/+custom/' \
--expression "/#reference_genome/ s/\$/-$CUSTOM_GENOME_NAME/" \
--expression "/#reference_version/ s/\$/-$CUSTOM_GENOME_VERSION/" > $OUTPUT
