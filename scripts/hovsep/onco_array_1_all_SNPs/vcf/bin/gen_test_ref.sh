#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ************************************************** defining raw data position **************************************************
tmp_dir="$script_dir/../tmp"

annovar_db_dir="/glob/jessada/tools/annovar/humandb"
ref_1000g_file="$annovar_db_dir/hg19_ALL.sites.2014_10.txt"
ref_MT_file="$annovar_db_dir/hg19_mitimpact2.txt"

out_dir="$script_dir/../out"
out_test_ref_1000g="$out_dir/test_ref_1000g.txt"
out_test_ref_MT="$out_dir/test_ref_MT.txt"
#clean_assoc_data_root_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/hovsep_study/clean"
#
#genotype_data_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/genotype"
#genotype_bfile_prefix="$genotype_data_dir/correct_oncoarray_quality-controlled_genotypes_v1_2015-10-22_SWEDEN-Lindblom"
#
#out_dir="$script_dir/../out/"
#significant_snps_file="$out_dir/list_of_uniq_snps.txt"
#coor_file="$out_dir/coor.txt"
# ************************************************** defining raw data position **************************************************

msg_to_out ()
{
    local message="$1"
    echo "$message" 1>&2
}

info_msg ()
{
    local message="$1"

    INFO_MSG_FORMAT="## [INFO] %s"
    local formated_msg=`printf "$INFO_MSG_FORMAT" "$message"`
    msg_to_out "$formated_msg"
}

debug_msg ()
{
    local message="$1"

    DEBUG_MSG_FORMAT="## [DEBUG] %s"
    local formated_msg=`printf "$DEBUG_MSG_FORMAT" "$message"`
    if [ "$dev_mode" == "On" ]
    then
        msg_to_out "$formated_msg"
    else
        write_log "$formated_msg"
    fi
}

:>$out_test_ref_1000g
tmp_extracted_SNPs="$tmp_dir/extract_snps.map"
chroms_list=`cut -f1 $tmp_extracted_SNPs | uniq`
for chrom in $chroms_list
do
    if [ "$chrom" -eq 23 ]
    then
        ref_chrom="X"
    elif [ "$chrom" -eq 24 ]
    then
        ref_chrom="Y"
    elif [ "$chrom" -eq 26 ]
    then
        continue
    else
        ref_chrom=$chrom
    fi
    grep_cmd="grep \"^$ref_chrom\" $ref_1000g_file | head -2000 >> $out_test_ref_1000g"
    info_msg "$grep_cmd"
    eval "$grep_cmd"
done
cmd="head -2000 $ref_MT_file > $out_test_ref_MT"
info_msg "$cmd"
eval "$cmd"
