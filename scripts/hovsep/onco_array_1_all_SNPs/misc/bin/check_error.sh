#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ************************************************** defining raw data position **************************************************
clean_assoc_data_root_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/hovsep_study/clean"

tmp_dir="$script_dir/../tmp"
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

# ************************************************** generate a list all assoc.hap together number of rows that have invalid number of columns **************************************************
#for full_folder in $raw_assoc_data_root_dir/assoc*
#do
#    if [ -d $full_folder ]
#    then
#        new_folder=$tmp_dir/${full_folder##*/}
#        mkdir $new_folder
#        for full_file in $full_folder/*
#        do
#            clean_file=`echo ${full_file##*/} |  tr '[:upper:]' '[:lower:]'`
#            new_file="$new_folder/$clean_file"
#            info_msg $full_file
#            info_msg $new_file
#            sed 's/,/./Ig' $full_file | sed -e 's///g' > $new_file
#        done
#    fi
#done

for folder in $clean_assoc_data_root_dir/*
#for folder in $clean_assoc_data_root_dir/*
do
    for file in $folder/*
    do
        err_count=`sed 's/[ \t]*$//' $file | awk -F'\t' '{ print NF }' | grep -v "8" | wc -l`
        if [ $err_count -ne 0 ]
        then
            echo ${folder##*/}/${file##*/}
            echo $err_count
        fi
    done
done

# ************************************************** generate a list of significant SNPs **************************************************

## ************************************************** defining raw data position **************************************************
#raw_dir="$script_dir/raw"
#
#onco_array_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/"
#onco_array_bin_prefix="$onco_array_dir/corect_oncoarray_quality-controlled_genotypes_v1_2015-10-22_SWEDEN-Lindblom"
#
##fam24_haplo_dir="/glob/jessada/private/master_data/CMM/haplotype/fam24/"
##fam24_haplo_bin_prefix="$fam24_haplo_dir/Haplotype_fam24"
##
##onco_array_bin_prefix="$fam24_haplo_bin_prefix"
#
#ref_dir="/glob/jessada/tools/annovar/humandb/"
#ref_file="$ref_dir/hg19_ALL.sites.2014_10.txt"
##ref_file="$ref_dir/hg19_tmp_onco_array.txt"
#
#tmp_dir="$script_dir/../tmp"
#tmp_plink_snp="$tmp_dir/onco_array_plink_snp"
#tmp_snp="$tmp_dir/onco_array_snp.txt"
#tmp_coor="$tmp_dir/onco_array_coor.txt"
#
#out_dir="$script_dir/../out"
#out_onco_array_vcf_file="$out_dir/onco_array.vcf"
#
## ************************************************** defining raw data position **************************************************
#
## ************************************************** extract snps **************************************************
##plink_cmd="plink --noweb --bfile $onco_array_bin_prefix --recode --out $tmp_plink_snp"
##eval $plink_cmd
##
##map2snp_cmd="cut -f2 $tmp_plink_snp.map > $tmp_snp"
##eval $map2snp_cmd
## ************************************************** extract snps **************************************************
#
## ************************************************** create vcf **************************************************
##join_cmd="join -t $'\t' -1 1 -2 6 -o 2.1,2.2,2.3,2.4 <( sort $tmp_snp ) <( sort -k6,6 $ref_file ) | sort -n -k2,2 > $tmp_coor"
##eval $join_cmd
#
#echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO" > $out_onco_array_vcf_file
#awk_cmd_pipe=" | awk -F'\t' '{ printf \"%s\t%s\t\t%s\t%s\t\t\t%s\n\", \$1, \$2, \$3, \$4, \".\" }' >> $out_onco_array_vcf_file"
#
#coor2vcf_cmd=" grep '^[0-9]' $tmp_coor | sort -n -k1,1 -k2,2"
#coor2vcf_cmd+="$awk_cmd_pipe"
#eval "$coor2vcf_cmd"
#
#coor2vcf_cmd=" grep -v '^[0-9]' $tmp_coor | sort -k1,1 -k2,2n"
#coor2vcf_cmd+="$awk_cmd_pipe"
#eval "$coor2vcf_cmd"
#
#
#
##cat $out_onco_array_vcf_file
## ************************************************** create vcf **************************************************
