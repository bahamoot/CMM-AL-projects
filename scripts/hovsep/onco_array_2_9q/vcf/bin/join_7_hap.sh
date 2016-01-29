#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

out_dir="$script_dir/../out"
out_raw="$out_dir/9q_7_oncoarray_raw.txt"
out_filtered_pvalue="$out_dir/9q_7_oncoarray_filtered_pvalue.txt"
out_db="$out_dir/hg19_CMM_9q_7_study.txt"
out_vcf="$out_dir/9q_7_oncoarray.vcf"

hap_data_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/chr9"
hap_file_1="$hap_data_dir/assoc1_9q_all_cases_vs_ctrls.assoc.hap"
hap_file_2="$hap_data_dir/assoc2_9q_all_cases_vs_non_uppsala.assoc.hap"
hap_file_3="$hap_data_dir/assoc3_9q_uppsala_vs_non_uppsala.assoc.hap"
hap_file_4="$hap_data_dir/assoc4_9q_familial_vs_supercontrols.assoc.hap"
hap_file_5="$hap_data_dir/assoc5_9q_all_cases_vs_uppsala.assoc.hap"
hap_file_6="$hap_data_dir/assoc6_9q_all_cases_vs_super_ctrls.assoc.hap"
hap_file_7="$hap_data_dir/assoc7_9q_all_cases_vs_Stockholm.assoc.hap"

genotype_data_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/genotype"
genotype_bfile_prefix="$genotype_data_dir/correct_oncoarray_quality-controlled_genotypes_v1_2015-10-22_SWEDEN-Lindblom"

data_dir="$script_dir/../data"
ref_file="$data_dir/hg19_ALL.sites.2014_10_chr9.txt"
snp_file="$data_dir/hg19_snp138_chr9.txt"

tmp_dir="$script_dir/../tmp"

tmp_1="$tmp_dir/tmp_1.txt"
tmp_2="$tmp_dir/tmp_2.txt"
tmp_3="$tmp_dir/tmp_3.txt"
tmp_4="$tmp_dir/tmp_4.txt"
tmp_5="$tmp_dir/tmp_5.txt"
tmp_6="$tmp_dir/tmp_6.txt"
tmp_7="$tmp_dir/tmp_7.txt"
#
#tmp_all_SNPs_raw="$tmp_dir/tmp_all_SNPs_raw.txt"
#tmp_all_SNPs_sorted="$tmp_dir/tmp_all_SNPs_sorted.txt"

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

COL_HAP_ASSOC_LOCUS=1
COL_HAP_ASSOC_HAPLOTYPE=2
COL_HAP_ASSOC_F_A=3
COL_HAP_ASSOC_F_U=4
COL_HAP_ASSOC_CHISQ=5
COL_HAP_ASSOC_DF=6
COL_HAP_ASSOC_P_VALUE=7
COL_HAP_ASSOC_SNPS=8

function join_hap {
    prime_SNPs=$1
    raw_input_file=$2

    filtered_input_file="$tmp_dir/filtered_input_file"

    # ---------- filtering haplotype with F_A, F_U, and P value, then recode it to have SNPs no in the first column --------------
    filtering_haplotype_cmd="awk '{
        F_A=strtonum(\$$COL_HAP_ASSOC_F_A)
        F_U=strtonum(\$$COL_HAP_ASSOC_F_U)
        P_VALUE=strtonum(\$$COL_HAP_ASSOC_P_VALUE)
#        if ((F_A > F_U) && (P_VALUE < 0.05))
        if (F_A > F_U)
            printf \"%s\t%s\t%s\t%s\t%s\n\", \$$COL_HAP_ASSOC_SNPS, \$$COL_HAP_ASSOC_HAPLOTYPE, \$$COL_HAP_ASSOC_F_A, \$$COL_HAP_ASSOC_F_U, \$$COL_HAP_ASSOC_P_VALUE
    }' $raw_input_file | sort -k1,1 > $filtered_input_file.assoc.hap"

#    info_msg "$filtering_haplotype_cmd"
    eval "$filtering_haplotype_cmd"

    prime_SNPs_cols=`head -1 $prime_SNPs | wc -w`
    join_format_first_clause="1.1,1.2,1.3,1.4,1.5"
    for (( i=6; i<=$prime_SNPs_cols; i++ ))
    do
        join_format_first_clause+=",1.$i"
    done
#    info_msg $prime_SNPs_cols
#    info_msg $join_format_first_clause

    join_cmd="join"
    join_cmd+=" -t $'\t'"
    join_cmd+=" -1 5 -2 1"
    join_cmd+=" -a 1"
    join_cmd+=" -e ."
    join_cmd+=" -o $join_format_first_clause,2.2,2.3,2.4,2.5 $prime_SNPs $filtered_input_file.assoc.hap"
    info_msg "$join_cmd"
    eval "$join_cmd"
}

# ************************************************** extract snps **************************************************
tmp_extracted_SNPs_prefix="$tmp_dir/tmp_extracted_SNPs"
tmp_extracted_SNPs="$tmp_extracted_SNPs_prefix".map
tmp_sorted_9q_SNPs="$tmp_dir/sorted_9q_SNPs.txt"
tmp_coor_1="$tmp_dir/tmp_coor_1.txt"
tmp_coor_2="$tmp_dir/tmp_coor_2.txt"
tmp_coor="$tmp_dir/coor.txt"

# Using genotyping data to generate SNPs in 9q region
chr=9
from_bp=98307128
to_bp=105545040

plink_cmd="plink"
plink_cmd+=" --bfile $genotype_bfile_prefix"
plink_cmd+=" --chr $chr"
plink_cmd+=" --from-bp $from_bp"
plink_cmd+=" --to-bp $to_bp"
plink_cmd+=" --recode"
#plink_cmd+=" --write-snplist"
plink_cmd+=" --out $tmp_extracted_SNPs_prefix"
eval "$plink_cmd"

# Sort and re-format SNPs 
sort_cmd="awk '{ printf \"%s\t%s\t%s\n\", \$4, \$1, \$2 }'  $tmp_extracted_SNPs | sort -k1,1 > $tmp_sorted_9q_SNPs"
info_msg "$sort_cmd"
eval "$sort_cmd"

# Generate coordinate file
join_cmd="join -t $'\t' -1 1 -2 2 -a 1 -e NA -o 2.1,2.2,2.3,2.4,1.3 $tmp_sorted_9q_SNPs $ref_file | sort -k5,5 > $tmp_coor_1"
info_msg "$join_cmd"
eval $join_cmd
## Generate coordinate file
#join_cmd="join -t $'\t' -1 3 -2 4 -a 1 -e NA -o 1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,2.1,2.2,2.7,2.8,2.4,2.9,2.10 $tmp_coor_1 $snp_file > $tmp_coor_2"
#info_msg "$join_cmd"
#eval $join_cmd

cp $tmp_coor_1 $tmp_coor
# ************************************************** extract snps **************************************************

# ************************************************** join 7 files **************************************************
# join result
join_hap $tmp_coor $hap_file_1 > $tmp_1
join_hap $tmp_1 $hap_file_2 > $tmp_2
join_hap $tmp_2 $hap_file_3 > $tmp_3
join_hap $tmp_3 $hap_file_4 > $tmp_4
join_hap $tmp_4 $hap_file_5 > $tmp_5
join_hap $tmp_5 $hap_file_6 > $tmp_6
join_hap $tmp_6 $hap_file_7 > $tmp_7

# sort the result by position
sort -n -k2,2 $tmp_7  > $out_raw

# filter only the record with p-value < 0.05 in at least on study
COOR_LEN=`head -1 $tmp_coor | wc -w`
info_msg $COOR_LEN
N_JOIN_FILES=7
condition_clause="((\$$((COOR_LEN+4)) < 0.05) && (\$$((COOR_LEN+4)) != \".\"))"
for (( i=2; i<=$N_JOIN_FILES; i++ ))
do
    condition_clause+=" || ((\$$((COOR_LEN+i*4)) < 0.05) && (\$$((COOR_LEN+i*4)) != \".\"))"
done
sort_cmd="awk '{ if ($condition_clause) print \$0}' $out_raw > $out_filtered_pvalue"
info_msg "$sort_cmd"
eval "$sort_cmd"
# ************************************************** join 7 files **************************************************

# ************************************************** create generic db file **************************************************
header="#Chr\tStart\tEnd\tRef\tAlt\tAssoc_SNPs"
for (( i=1; i<=$N_JOIN_FILES; i++ ))
do
    header+="\thaplotype_$i"
    header+="\tF_A_$i"
    header+="\tF_U_$i"
    header+="\tP-value_$i"
done
echo -e "$header" > $out_db
awk -F'\t' '{ if ((length($3) == 1) && (length($4) == 1)) print $0 }' $out_raw | awk -F'\t' '{$3=$2 FS $3;}1' OFS='\t' >> $out_db
# ************************************************** create generic db file **************************************************

# ************************************************** create vcf **************************************************
echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO" > $out_vcf
awk_cmd_pipe=" | awk -F'\t' '{ if ((length(\$3) == 1) && (length(\$4) == 1)) printf \"%s\t%s\t%s\t%s\t%s\t.\t.\t.\n\", \$1, \$2, \$5, \$3, \$4 }' >> $out_vcf"
#awk_cmd_pipe=" | awk -F'\t' '{ if ((length(\$3) == 1) && (length(\$4) == 1)) print \$0 }' >> $out_vcf"
#awk_cmd_pipe=" | awk -F'\t' '{ print NF }' >> $out_vcf"

coor2vcf_cmd=" cat $out_raw"
#coor2vcf_cmd=" grep '^[0-9]' $tmp_coor | sort -n -k1,1 -k2,2"
coor2vcf_cmd+="$awk_cmd_pipe"
info_msg "$coor2vcf_cmd"
eval "$coor2vcf_cmd"
#
#coor2vcf_cmd=" grep -v '^[0-9]' $tmp_coor | sort -k1,1 -k2,2n"
#coor2vcf_cmd+="$awk_cmd_pipe"
#eval "$coor2vcf_cmd"
# ************************************************** create vcf **************************************************

