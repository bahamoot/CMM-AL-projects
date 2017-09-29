#!/bin/bash

# exit on error
set -e
set -o pipefail

source $PYCMM/bash/cmm_functions.sh

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="WES294"
vcf_tabix_file="$VCF_WES294_WO_STAR"
project_out_dir="$VCF2AVDB_COOR_OUTPUT_DIR/vcf2avdb_coor_$dataset_name"
data_out_dir="$project_out_dir/data_out"
out_file="$data_out_dir/$dataset_name.vcf"

mkdir -p "$data_out_dir"

cmd="$PYCMM/bash/cmmdb_vcf2avdb_coor.sh"
cmd+=" -i $vcf_tabix_file"
cmd+=" -o $out_file"

#info_msg "$cmd"

eval_cmd "$cmd"
