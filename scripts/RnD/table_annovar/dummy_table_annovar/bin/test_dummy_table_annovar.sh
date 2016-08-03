#!/bin/bash
 
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-dummy-table-annovar"
cmd+=" --dataset_name dummy_test"
cmd+=" --input_file $script_dir/../data/input.vcf.gz"
cmd+=" --db_folder $ANNOVAR_HUMAN_DB_DIR"
cmd+=" --protocols refGene,cytoBand,genomicSuperDups"
cmd+=" --operations g,r,r"
cmd+=" --data_out_folder $script_dir/../out"

eval "$cmd"
