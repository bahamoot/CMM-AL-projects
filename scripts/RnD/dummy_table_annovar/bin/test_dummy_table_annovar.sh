#!/bin/bash
 
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-dummy-table-annovar"
cmd+=" --dataset_name dummy_test"
cmd+=" --input_file /home/jessada/private/projects/CMM/scripts/RnD/dummy_table_annovar/data/input.vcf.gz"
cmd+=" --db_folder /glob/jessada/tools/annovar/humandb/"
cmd+=" --protocols refGene,cytoBand,genomicSuperDups"
cmd+=" --operations g,r,r"
cmd+=" --data_out_folder /home/jessada/private/projects/CMM/scripts/RnD/dummy_table_annovar/out"

eval "$cmd"
