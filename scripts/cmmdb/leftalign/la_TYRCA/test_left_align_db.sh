#!/bin/bash

module load annovar

source $PYCMM/bash/cmm_functions.sh
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

script_create_left_align_vcf="$script_dir/create_left_align_vcf.sh"
#script_create_left_align_db="$script_dir/create_left_align_db.sh"
script_create_vcf2avdb_key_table="$script_dir/create_vcf2avdb_key_table.sh"
script_mutstat2avdb="$script_dir/mutstat2avdb.sh"

dataset_name="only_indel"

data_dir="$script_dir/../data/"
input_vcf_gz="$data_dir/$dataset_name.vcf.gz"

tmp_dir="$script_dir/../tmp/"
mutstat_out="$tmp_dir/$dataset_name.mutstat.txt"

out_dir="$script_dir/../out/"
left_align_vcf="$out_dir/$dataset_name.left_align.vcf"
left_align_vcf_gz="$out_dir/$dataset_name.left_align.vcf.gz"
vcf2avdb_key="$out_dir/$dataset_name.vcf2avdb_key.txt"
avdb_out="$out_dir/hg19_CMM_$dataset_name.avdb.txt"
ta_out_prefix="$out_dir/$dataset_name.ta"


#cmd="$script_create_left_align_vcf"
#cmd+=" $input_vcf_gz"
#cmd+=" $left_align_vcf"
#eval_cmd "$cmd"
#
#bgzip -f $left_align_vcf
#tabix -f -p vcf $left_align_vcf_gz

#cmd="$script_create_vcf2avdb_key_table"
#cmd+=" $left_align_vcf_gz"
#cmd+=" $dataset_name"
#cmd+=" $vcf2avdb_key"
#eval_cmd "$cmd"
#
#
## convert allele frequency into annovar format
#cmd="$PYCMM/bash/vcf_AF_to_annovar.sh"
#cmd+=" -k $dataset_name"
#cmd+=" -i $left_align_vcf_gz"
#cmd+=" -r 2"
#cmd+=" -o $mutstat_out"
#eval_cmd "$cmd"
#
#cmd="$script_mutstat2avdb"
#cmd+=" $mutstat_out"
#cmd+=" $vcf2avdb_key"
#cmd+=" $dataset_name"
#cmd+=" $avdb_out"
#eval_cmd "$cmd"
#
table_annovar_cmd="table_annovar.pl"
table_annovar_cmd+=" $left_align_vcf_gz"
table_annovar_cmd+=" $ANNOVAR_HUMAN_DB_DIR"
table_annovar_cmd+=" -buildver hg19"
table_annovar_cmd+=" -out $ta_out_prefix"
table_annovar_cmd+=" -protocol CMM_only_indel"
table_annovar_cmd+=" -operation f"
table_annovar_cmd+=" -nastring ."
table_annovar_cmd+=" -vcfinput"
eval_cmd "$table_annovar_cmd"
