#!/bin/bash

# exit on error
set -e
set -o pipefail

source $PYCMM/bash/cmm_functions.sh

#script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="swegen"
vcf_tabix_file="/proj/b2011117/private/databases/third_party/swegen/swegen_20161223/SWEGEN_20161223.vcf.gz"
project_out_dir="$VCF2AVDB_KEY_OUTPUT_DIR/vcf2avdb_key_$dataset_name"
data_out_dir="$project_out_dir/data_out"
out_file="$data_out_dir/$dataset_name.vcf2avdb.key"
#sample_info="$SAMPLES_LIST_DIR/Exome_OAF_CRC.list"
#sample_info="/glob/jessada//private/master_data/CMM/family/processed/uppsala//uppsala_pats_all_members.lst.all"
#project_code="b2011097"
#jobs_setup_file=cal_mut_stat_"$dataset_name"_jobs_setup.txt

mkdir -p "$data_out_dir"

cmd="$PYCMM/bash/cmmdb_vcf2avdb_key.sh"
cmd+=" -k $dataset_name"
cmd+=" -i $vcf_tabix_file"
cmd+=" -o $out_file"

#info_msg "$cmd"

eval_cmd "$cmd"
