#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="OAF_EARLYONSET"
input_folder="$MUTSTAT_OUTPUT_DIR/WES/cal_stat_$dataset_name/data_out"
out_file="$input_folder/hg19_CMM_OAF_EARLYONSET.txt"

cmd="$PYCMM/bash/cmmdb_concat_stat.sh"
cmd+=" -k $dataset_name"
cmd+=" -d $input_folder"
cmd+=" -o $out_file"

eval "$cmd"