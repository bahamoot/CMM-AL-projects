#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ************************************************** defining raw data position **************************************************
clean_assoc_data_root_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/hovsep_study/clean"

genotype_data_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/genotype"
genotype_bfile_prefix="$genotype_data_dir/correct_oncoarray_quality-controlled_genotypes_v1_2015-10-22_SWEDEN-Lindblom"
onchip2rs_conversion="$genotype_data_dir/onchip2rs_conversion.txt"

out_dir="$script_dir/../out/"
significant_snps_file="$out_dir/list_of_uniq_snps.txt"
coor_file="$out_dir/coor.txt"
out_vcf="$out_dir/oncoarray_gw.vcf"
out_db="$out_dir/hg19_CMM_oncoarray_gw.txt"
out_raw_join_assoc_hap="$out_dir/raw_join_assoc_hap.txt"

annovar_db_dir="/glob/jessada/tools/annovar/humandb"
ref_1000g_ALL_file="$annovar_db_dir/hg19_ALL.sites.2014_10.txt"
ref_1000g_EUR_file="$annovar_db_dir/hg19_EUR.sites.2014_10.txt"
#ref_1000g_ALL_file="$out_dir/test_ref_1000g.txt"
ref_MT_file="$annovar_db_dir/hg19_mitimpact2.txt"
#ref_MT_file="$out_dir/test_ref_MT.txt"

tmp_dir="$script_dir/../tmp/"

cache_dir="$script_dir/../cache"
cache_1000g_ALL_sort_rs="$cache_dir/cache_1000g_ALL_sort_rs.txt"
cache_1000g_EUR_sort_rs="$cache_dir/cache_1000g_EUR_sort_rs.txt"
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

ref_chroms_1000g_list="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y"
ref_chroms_mt_list="MT"
ref_chroms_list="$ref_chrom_1000g_list $ref_chrom_mt_list"

function get_cache_1000g_ALL_sort_rs_by_chr {
    chrom=$1
    echo ${cache_1000g_ALL_sort_rs%.*}_chr$chrom.txt
}
function get_cache_1000g_EUR_sort_rs_by_chr {
    chrom=$1
    echo ${cache_1000g_EUR_sort_rs%.*}_chr$chrom.txt
}
# ************************************************** cache data preparation **************************************************
## prepare sorted ANNOVAR 1000Genomes (whole genomes)
##grep_cmd="grep -v \"\\.$\" $ref_1000g_ALL_file | sort -k6,6 > $cache_1000g_ALL_sort_rs"
##info_msg "executing: $grep_cmd"
##eval "$grep_cmd"
#
## prepare sorted ANNOVAR 1000Genomes ALL (for each chromosome)
#tmp_ref_1000g_with_snp_id=`mktemp`
#info_msg "temporary snps file with snp id: $tmp_ref_1000g_with_snp_id"
#grep -v "\.$" $ref_1000g_ALL_file > $tmp_ref_1000g_with_snp_id
#for ref_chrom in $ref_chroms_1000g_list
#do
#    cache_ref_1000g_chrom_file=`get_cache_1000g_ALL_sort_rs_by_chr $ref_chrom`
#    grep_cmd=" grep -P \"^$ref_chrom\t\" $tmp_ref_1000g_with_snp_id | sort -k6,6 > $cache_ref_1000g_chrom_file "
#    info_msg "$grep_cmd"
#    eval $grep_cmd
#done
#
## prepare sorted ANNOVAR 1000Genomes EUR (for each chromosome)
#tmp_ref_1000g_with_snp_id=`mktemp`
#info_msg "temporary snps file with snp id: $tmp_ref_1000g_with_snp_id"
#grep -v "\.$" $ref_1000g_EUR_file > $tmp_ref_1000g_with_snp_id
#for ref_chrom in $ref_chroms_1000g_list
#do
#    cache_ref_1000g_chrom_file=`get_cache_1000g_EUR_sort_rs_by_chr $ref_chrom`
#    grep_cmd=" grep -P \"^$ref_chrom\t\" $tmp_ref_1000g_with_snp_id | sort -k6,6 > $cache_ref_1000g_chrom_file "
#    info_msg "$grep_cmd"
#    eval $grep_cmd
#done
# ************************************************** cache data preparation **************************************************

# ************************************************** generate a list of significant SNPs **************************************************
#tmp_snps_file=`mktemp`
#raw_significant_snps_file=`mktemp`
#info_msg "temporary snps file: $tmp_snps_file"
#info_msg "raw significant snps file: $raw_significant_snps_file"
#for full_folder in $clean_assoc_data_root_dir/assoc*
#do
#    if [ -d $full_folder ]
#    then
#        for full_file in $full_folder/*
#        do
#            sort -k8,8 $full_file | awk -F '\t' '{ if ($7 < 0.05) print $0 }' | cut -f8 >> $tmp_snps_file
#        done
#    fi
#done
#sort $tmp_snps_file | uniq > $raw_significant_snps_file
#
## use the SNP ID from the study to look up in the conversion table
## the first column in the result is the ID from the study
## the second column is the corresponding ID from the table
## NA in the second column means there is no corresponding ID
#join -t $'\t' -1 1 -2 1 -a 1 -e NA -o 1.1,2.2 $raw_significant_snps_file <( sort -k1,1 $onchip2rs_conversion ) > $significant_snps_file
# ************************************************** generate a list of significant SNPs **************************************************

# ************************************************** extract snps & coordinate **************************************************
#tmp_extract_snps_input=`mktemp`
#tmp_extracted_snps_prefix=`mktemp`
#tmp_extracted_snps="$tmp_extracted_snps_prefix".map
#
#cut -f1 $significant_snps_file | sort | uniq > $tmp_extract_snps_input
#plink_cmd="plink"
#plink_cmd+=" --noweb"
#plink_cmd+=" --bfile $genotype_bfile_prefix"
#plink_cmd+=" --recode"
#plink_cmd+=" --chr Y"
#plink_cmd+=" --extract $tmp_extract_snps_input"
#plink_cmd+=" --out $tmp_extracted_snps_prefix"
#eval "$plink_cmd"
#
#function generate_coordinate {
#    map_file="$1"
#    significant_snps_with_correction="$2"
#    # format of reference file
#    # 1 CHROM
#    # 2 POS
#    # 3 REF
#    # 4 ALT
#    # 5 
#    # 6 SNP ID
#    # and it should be sorted
#    ref_file="$3"
#    ref_chrom="$4"
#    assoc_chrom="$5"
#
#    tmp_sorted_snps=`mktemp`
#    tmp_sorted_snps_with_correct_id=`mktemp`
#    tmp_coordinates=`mktemp`
#    tmp_snps_not_in_ref=`mktemp`
#
#    # Sort and re-format SNPs by adding mock-up info 
#    sort_cmd="grep -P \"^$assoc_chrom\t\" $map_file | sed 's/^23/X/g' | sed 's/^24/Y/g' | sed 's/^26/MT/g' | awk '{ printf \"%s\t%s\tNA\tA\t%s\t.\t.\n\", \$1, \$4, \$2 }' | sort -k5,5 > $tmp_sorted_snps"
#    info_msg "$sort_cmd"
#    eval "$sort_cmd"
#
#    # append corrected snp ID
#    join_cmd="join -t $'\t'"
#    join_cmd+=" -1 5 -2 1"
#    join_cmd+=" -o 1.1,1.2,1.3,1.4,1.5,2.2"
#    join_cmd+=" $tmp_sorted_snps"
#    join_cmd+=" $significant_snps_with_correction"
#    join_cmd+=" | sort -k6,6"
#    join_cmd+=" > $tmp_sorted_snps_with_correct_id"
#    info_msg "$join_cmd"
#    eval "$join_cmd"
#
#    # create correct coordinate using snp ID to look in the reference file
#    join_cmd="join -t $'\t'"
#    join_cmd+=" -1 6 -2 6"
#    join_cmd+=" -o 2.1,2.2,2.3,2.4,1.5,2.6"
#    join_cmd+=" $tmp_sorted_snps_with_correct_id"
#    join_cmd+=" $ref_file"
#    join_cmd+=" > $tmp_coordinates"
#    info_msg "$join_cmd"
#    eval "$join_cmd"
#
#    # generate list of signficant snps that are not in the reference file
#    comm_cmd="comm -23"
#    comm_cmd+=" <( cut -f5 $tmp_sorted_snps_with_correct_id | sort )"
#    comm_cmd+=" <( cut -f5 $tmp_coordinates | sort )"
#    comm_cmd+=" > $tmp_snps_not_in_ref"
#    info_msg "$comm_cmd"
#    eval "$comm_cmd"
#
#    # generate mock up coordinate from the SNPs that are not in the reference using pre-generated mock-up position
#    join_cmd="join -t $'\t'"
#    join_cmd+=" -1 1 -2 5"
#    join_cmd+=" -o 2.1,2.2,2.3,2.4,2.5,2.6"
#    join_cmd+=" $tmp_snps_not_in_ref"
#    join_cmd+=" <( sort -k5,5 $tmp_sorted_snps_with_correct_id )"
#    join_cmd+=" >> $tmp_coordinates"
#    info_msg "$join_cmd"
#    eval "$join_cmd"
#
#    sort -k2,2n "$tmp_coordinates"
#}
#
#:>$coor_file
## generate coordinate using reference from 1000G
#chroms_list=`cut -f1 $tmp_extracted_snps | uniq`
#for assoc_chrom in $chroms_list
#do
#    if [ "$assoc_chrom" -eq 23 ]
#    then
#        ref_chrom="X"
#    elif [ "$assoc_chrom" -eq 24 ]
#    then
#        ref_chrom="Y"
#    elif [ "$assoc_chrom" -eq 26 ]
#    then
#        continue
#    else
#        ref_chrom=$assoc_chrom
#    fi
#
#    cache_ref_1000g_chrom_file=`get_cache_1000g_ALL_sort_rs_by_chr $ref_chrom`
#    info_msg $cache_ref_1000g_chrom_file
#
#    generate_coordinate "$tmp_extracted_snps" "$significant_snps_file" "$cache_ref_1000g_chrom_file" "$ref_chrom" "$assoc_chrom" >> $coor_file
#done
#
#tmp_reformat_mt_ref_file=`mktemp`
#reformat_cmd="cut"
#reformat_cmd+=" -f1,2,4-6,18"
#reformat_cmd+=" $ref_MT_file"
#reformat_cmd+=" | awk -F'\t' '{ if (\$6 != \"-\") printf \"%s\t.\t.\n\", \$0 }'"
#reformat_cmd+=" | sort -k6,6"
#reformat_cmd+=" > $tmp_reformat_mt_ref_file"
#info_msg "$reformat_cmd"
#eval "$reformat_cmd"
#
#generate_coordinate "$tmp_extracted_snps" "$significant_snps_file" "$tmp_reformat_mt_ref_file" "MT" "26" >> $coor_file
#
### use converted SNP ID to look up for the frequencies in 1000Genomes
##raw_1000g_coor="$tmp_dir/raw_1000g_coor.txt"
###raw_1000g_coor_file=`mktemp`
##info_msg "temporary coordinate file from 1000g: $raw_1000g_coor"
##
##join_cmd="join -t $'\t' -1 2 -2 6 -e NA -o 2.1,2.2,2.3,2.4,1.1,1.2 <( grep -v \"NA\" $significant_snps_file | grep -v \"\\.\" | sort -k2,2 ) $cache_1000g_ALL_sort_rs"
###join_cmd+=" | sort -k5,5"
###join_cmd+=" | awk -F'\t' '{"
###join_cmd+=" if (\$4 == \"1\")"
###join_cmd+="   printf \"%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$3, \"-\", \$5;"
###join_cmd+=" else"
###join_cmd+="   printf \"%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$3, \$4, \$5;"
###join_cmd+=" }'"
##join_cmd+=" > $raw_1000g_coor"
##info_msg "$join_cmd"
##eval $join_cmd
#
# ************************************************** extract snps & coordinate **************************************************

# ************************************************** create output vcf file **************************************************
#echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO" > $out_vcf
#awk_cmd_pipe=" | awk -F'\t' '{ printf \"%s\t%s\t%s\t%s\t%s\t.\t.\t.\n\", \$1, \$2, \$5, \$3, \$4 }'  >> $out_vcf"
##awk_cmd_pipe=" | awk -F'\t' '{ if ((length(\$3) == 1) && (length(\$4) == 1)) printf \"%s\t%s\t%s\t%s\t%s\t.\t.\t.\n\", \$1, \$2, \$5, \$3, \$4 }'  >> $out_vcf"
#
#coor2vcf_cmd="grep '^[0-9]' $coor_file | sort -n -k1,1 -k2,2"
#coor2vcf_cmd+="$awk_cmd_pipe"
#info_msg "$coor2vcf_cmd"
#eval $coor2vcf_cmd
#
#coor2vcf_cmd="grep -v '^[0-9]' $coor_file | sort -k1,1 -k2,2n"
#coor2vcf_cmd+="$awk_cmd_pipe"
#info_msg "$coor2vcf_cmd"
#eval $coor2vcf_cmd
# ************************************************** create output vcf file **************************************************

# ************************************************** create outpuf generic db file **************************************************
#N_JOIN_FILES=8
#
#function join_hap {
#    # the assumption for using this function is that there is only haplotype association study file for one study
#    # it must not be split into chromosomes
#    COL_HAP_ASSOC_LOCUS=1
#    COL_HAP_ASSOC_HAPLOTYPE=2
#    COL_HAP_ASSOC_F_A=3
#    COL_HAP_ASSOC_F_U=4
#    COL_HAP_ASSOC_CHISQ=5
#    COL_HAP_ASSOC_DF=6
#    COL_HAP_ASSOC_P_VALUE=7
#    COL_HAP_ASSOC_SNPS=8
#    NEW_COL_HAP_ASSOC_SNPS=9
#    COL_HAP_ASSOC_INSERTED_OR=8
#
#    prime_SNPs=$1
#    raw_tab_hap_file=$2
#    tmp_tab_hap_with_odds_ratio=`mktemp`
#    tmp_filtered_hap_file=`mktemp`
#
#    cal_odds_ratio_cmd="awk '{
#    if (\$$COL_HAP_ASSOC_HAPLOTYPE == \"OMNIBUS\" || \$$COL_HAP_ASSOC_F_A == \"1\"  || \$$COL_HAP_ASSOC_F_A == \"0\" || \$$COL_HAP_ASSOC_F_U == \"1\" || \$$COL_HAP_ASSOC_F_U == \"0\") 
#        printf \"%s\t%s\t%s\t%s\t%s\t%s\t%s\tNA\t%s\n\", \$1, \$2, \$3, \$4, \$5, \$6, \$7, \$8
#    else if (\$$COL_HAP_ASSOC_HAPLOTYPE == \"HAPLOTYPE\")  
#        printf \"%s\t%s\t%s\t%s\t%s\t%s\t%s\tOR\t%s\n\", \$1, \$2, \$3, \$4, \$5, \$6, \$7, \$8
#    else {
#        F_A=strtonum(\$$COL_HAP_ASSOC_F_A)
#        F_U=strtonum(\$$COL_HAP_ASSOC_F_U)
#        odds_ratio=(F_A/(1-F_A))/(F_U/(1-F_U))
#        printf \"%s\t%s\t%s\t%s\t%s\t%s\t%s\t%0.4f\t%s\n\", \$1, \$2, \$3, \$4, \$5, \$6, \$7, odds_ratio, \$8
#        }
#    }' $raw_tab_hap_file > $tmp_tab_hap_with_odds_ratio"
#    eval "$cal_odds_ratio_cmd"
#
#    # ---------- filtering haplotype with F_A, F_U, and P value, then recode it to have SNPs no in the first column --------------
#    filtering_haplotype_cmd="awk '{
#        F_A=strtonum(\$$COL_HAP_ASSOC_F_A)
#        F_U=strtonum(\$$COL_HAP_ASSOC_F_U)
#        P_VALUE=strtonum(\$$COL_HAP_ASSOC_P_VALUE)
##        if ((F_A > F_U) && (P_VALUE < 0.05))
#        if (F_A > F_U)
#            printf \"%s\t%s\t%s\t%s\t%s\t%s\n\", \$$NEW_COL_HAP_ASSOC_SNPS, \$$COL_HAP_ASSOC_HAPLOTYPE, \$$COL_HAP_ASSOC_F_A, \$$COL_HAP_ASSOC_F_U, \$$COL_HAP_ASSOC_P_VALUE, \$$COL_HAP_ASSOC_INSERTED_OR
#    }' $tmp_tab_hap_with_odds_ratio | sort -k1,1 > $tmp_filtered_hap_file"
#
#    eval "$filtering_haplotype_cmd"
#
#    prime_SNPs_cols=`head -1 $prime_SNPs | wc -w`
#    join_format_first_clause="1.1"
#    for (( i=2; i<=$prime_SNPs_cols; i++ ))
#    do
#        join_format_first_clause+=",1.$i"
#    done
#
#    join_cmd="join"
#    join_cmd+=" -t $'\t'"
#    join_cmd+=" -1 5 -2 1"
#    join_cmd+=" -a 1"
#    join_cmd+=" -e ."
#    join_cmd+=" -o $join_format_first_clause,2.2,2.3,2.4,2.5,2.6 $prime_SNPs $tmp_filtered_hap_file"
#    info_msg "$join_cmd"
#    eval "$join_cmd"
#}
#
#tmp_join_input_file=`mktemp`
#sort -k5,5 $coor_file > $tmp_join_input_file
#for full_folder in $clean_assoc_data_root_dir/assoc*
#do
#    if [ -d $full_folder ]
#    then
#        for full_file in $full_folder/*
#        do
#            join_hap "$tmp_join_input_file" "$full_file" > "$out_raw_join_assoc_hap"
#            cp $out_raw_join_assoc_hap $tmp_join_input_file
#        done
#    fi
#done
#
#header="#Chr\tStart\tEnd\tRef\tAlt\tAssoc_SNPs\tCorrection_SNPs"
#for (( i=1; i<=$N_JOIN_FILES; i++ ))
#do
#    header+="\thaplotype_$i"
#    header+="\tF_A_$i"
#    header+="\tF_U_$i"
#    header+="\tP-value_$i"
#    header+="\tOR_$i"
#done
#echo -e "$header" > $out_db
##grep '^[0-9]' $out_raw_join_assoc_hap | sort -n -k1,1 -k2,2 | awk -F'\t' '{ if ((length($3) == 1) && (length($4) == 1)) print $0 }' | awk -F'\t' '{$3=$2 FS $3;}1' OFS='\t' >> $out_db
##grep -v '^[0-9]' $out_raw_join_assoc_hap | sort -k1,1 -k2,2n | awk -F'\t' '{ if ((length($3) == 1) && (length($4) == 1)) print $0 }' | awk -F'\t' '{$3=$2 FS $3;}1' OFS='\t' >> $out_db
#grep '^[0-9]' $out_raw_join_assoc_hap | sort -n -k1,1 -k2,2 | awk -F'\t' '{$3=$2 FS $3;}1' OFS='\t' >> $out_db
#grep -v '^[0-9]' $out_raw_join_assoc_hap | sort -k1,1 -k2,2n | awk -F'\t' '{$3=$2 FS $3;}1' OFS='\t' >> $out_db

# ************************************************** create outpuf generic db file **************************************************
