#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="SweGen"
input_folder="$MUTSTAT_OUTPUT_DIR/SweGen/first_release/data_out"
out_file="$input_folder/hg19_CMM_Swegen_20161223.txt"

cmd="$PYCMM/bash/cmmdb_concat_stat.sh"
cmd+=" -k $dataset_name"
cmd+=" -d $input_folder"
cmd+=" -o $out_file"

eval "$cmd"
