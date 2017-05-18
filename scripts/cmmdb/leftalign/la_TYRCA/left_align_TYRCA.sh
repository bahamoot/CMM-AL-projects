#!/bin/bash


source $PYCMM/bash/cmm_functions.sh

input_vcf_gz="/proj/b2011117/nobackup/private/projects_output/gatkbp/WGS/TYRCA/piper/TYRCA_piper_merge/vcf/TYRCA.VQSR.vcf.gz"

left_align_vcf="/proj/b2011117/nobackup/private/projects_output/gatkbp/WGS/TYRCA/piper/TYRCA_piper_merge/vcf/TYRCA.la.vcf"


cmd="$PYCMM/bash/cmmdb_leftalign_vcf.sh"
cmd+=" -i $input_vcf_gz"
cmd+=" -o $left_align_vcf"
eval_cmd "$cmd"

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
#table_annovar_cmd="table_annovar.pl"
#table_annovar_cmd+=" $left_align_vcf_gz"
#table_annovar_cmd+=" $ANNOVAR_HUMAN_DB_DIR"
#table_annovar_cmd+=" -buildver hg19"
#table_annovar_cmd+=" -out $ta_out_prefix"
#table_annovar_cmd+=" -protocol CMM_only_indel.avdb"
#table_annovar_cmd+=" -operation f"
#table_annovar_cmd+=" -nastring ."
#table_annovar_cmd+=" -vcfinput"
#eval_cmd "$table_annovar_cmd"
