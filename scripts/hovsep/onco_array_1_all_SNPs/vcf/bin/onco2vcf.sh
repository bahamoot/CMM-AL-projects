#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ************************************************** defining raw data position **************************************************
clean_assoc_data_root_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/hovsep_study/clean"

genotype_data_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/genotype"
genotype_bfile_prefix="$genotype_data_dir/correct_oncoarray_quality-controlled_genotypes_v1_2015-10-22_SWEDEN-Lindblom"

out_dir="$script_dir/../out/"
significant_snps_file="$out_dir/list_of_uniq_snps.txt"
coor_file="$out_dir/coor.txt"
out_vcf="$out_dir/oncoarray_gw.vcf"
out_db="$out_dir/hg19_CMM_oncoarray_gw.txt"
out_raw_join_assoc_hap="$out_dir/raw_join_assoc_hap.txt"

annovar_db_dir="/glob/jessada/tools/annovar/humandb"
ref_1000g_file="$annovar_db_dir/hg19_ALL.sites.2014_10.txt"
#ref_1000g_file="$out_dir/test_ref_1000g.txt"
ref_MT_file="$annovar_db_dir/hg19_mitimpact2.txt"
#ref_MT_file="$out_dir/test_ref_MT.txt"
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

# ************************************************** generate a list of significant SNPs **************************************************
#tmp_snps_file=`mktemp`
#info_msg "temporary snps file: $tmp_snps_file"
#for full_folder in $clean_assoc_data_root_dir/assoc*
#do
#    if [ -d $full_folder ]
#    then
#        for full_file in $full_folder/*
#        do
##            info_msg $full_file
#            sort -k8,8 $full_file | awk -F '\t' '{ if ($7 < 0.05) print $0 }' | cut -f8 >> $tmp_snps_file
#        done
#    fi
#done
#sort $tmp_snps_file | uniq > $significant_snps_file
# ************************************************** generate a list of significant SNPs **************************************************

# ************************************************** extract snps & coordinate **************************************************
tmp_extracted_SNPs_prefix=`mktemp`
info_msg "temporary extracted snps prefix: $tmp_extracted_SNPs_prefix"
tmp_extracted_SNPs="$tmp_extracted_SNPs_prefix".map
tmp_sorted_SNPs=`mktemp`
info_msg "temporary sorted snps : $tmp_sorted_SNPs"

plink_cmd="plink"
plink_cmd+=" --noweb"
plink_cmd+=" --bfile $genotype_bfile_prefix"
plink_cmd+=" --recode"
plink_cmd+=" --chr 26"
plink_cmd+=" --extract $significant_snps_file"
plink_cmd+=" --out $tmp_extracted_SNPs_prefix"
eval "$plink_cmd"

:>$coor_file
# generate coordinate using reference from 1000G
chroms_list=`cut -f1 $tmp_extracted_SNPs | uniq`
for assoc_chrom in $chroms_list
do
    if [ "$assoc_chrom" -eq 23 ]
    then
        ref_chrom="X"
    elif [ "$assoc_chrom" -eq 24 ]
    then
        ref_chrom="Y"
    elif [ "$assoc_chrom" -eq 26 ]
    then
        continue
    else
        ref_chrom=$assoc_chrom
    fi
    # Sort and re-format SNPs 
    sort_cmd="grep -P \"^$assoc_chrom\t\" $tmp_extracted_SNPs | awk '{ printf \"%s\t%s\t%s\n\", \$4, \$1, \$2 }' | sort -k1,1 > $tmp_sorted_SNPs"
    info_msg "$sort_cmd"
    eval "$sort_cmd"

    # Generate coordinate file
    join_cmd="join -t $'\t' -1 1 -2 2 -a 1 -e NA -o 2.1,2.2,2.3,2.4,1.3 $tmp_sorted_SNPs <( grep -P \"^$ref_chrom\t\" $ref_1000g_file | sort -k2,2 )"
    join_cmd+=" | sort -k5,5"
    join_cmd+=" | awk -F'\t' '{"
    join_cmd+=" if (\$4 == \"1\")"
    join_cmd+="   printf \"%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$3, \"-\", \$5;"
    join_cmd+=" else"
    join_cmd+="   printf \"%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$3, \$4, \$5;"
    join_cmd+=" }'"
    join_cmd+=" >> $coor_file"
    info_msg "$join_cmd"
    eval $join_cmd
done
# generate coordinate using reference from MT (mitochondria) database
# Sort and re-format SNPs 
sort_cmd="grep -P \"^26\t\" $tmp_extracted_SNPs | awk '{ printf \"%s\t%s\t%s\n\", \$4, \$1, \$2 }' | sort -k1,1 > $tmp_sorted_SNPs"
info_msg "$sort_cmd"
eval "$sort_cmd"
# Generate coordinate file
join_cmd="join -t $'\t' -1 1 -2 2 -a 1 -e NA -o 2.1,2.2,2.4,2.5,1.3 $tmp_sorted_SNPs <( sort -k2,2 $ref_MT_file  )"
join_cmd+=" | sort -k5,5"
join_cmd+=" | awk -F'\t' '{"
join_cmd+=" if (\$4 == \"1\")"
join_cmd+="   printf \"%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$3, \"-\", \$5;"
join_cmd+=" else"
join_cmd+="   printf \"%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$3, \$4, \$5;"
join_cmd+=" }'"
join_cmd+=" >> $coor_file"
info_msg "$join_cmd"
eval $join_cmd
# ************************************************** extract snps & coordinate **************************************************

# ************************************************** create output vcf file **************************************************
#echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO" > $out_vcf
#awk_cmd_pipe=" | awk -F'\t' '{ if ((length(\$3) == 1) && (length(\$4) == 1)) printf \"%s\t%s\t%s\t%s\t%s\t.\t.\t.\n\", \$1, \$2, \$5, \$3, \$4 }'  >> $out_vcf"
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
#    join_format_first_clause="1.1,1.2,1.3,1.4,1.5"
#    for (( i=6; i<=$prime_SNPs_cols; i++ ))
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
#header="#Chr\tStart\tEnd\tRef\tAlt\tAssoc_SNPs"
#for (( i=1; i<=$N_JOIN_FILES; i++ ))
#do
#    header+="\thaplotype_$i"
#    header+="\tF_A_$i"
#    header+="\tF_U_$i"
#    header+="\tP-value_$i"
#    header+="\tOR_$i"
#done
#echo -e "$header" > $out_db
#grep '^[0-9]' $out_raw_join_assoc_hap | sort -n -k1,1 -k2,2 | awk -F'\t' '{ if ((length($3) == 1) && (length($4) == 1)) print $0 }' | awk -F'\t' '{$3=$2 FS $3;}1' OFS='\t' >> $out_db
#grep -v '^[0-9]' $out_raw_join_assoc_hap | sort -k1,1 -k2,2n | awk -F'\t' '{ if ((length($3) == 1) && (length($4) == 1)) print $0 }' | awk -F'\t' '{$3=$2 FS $3;}1' OFS='\t' >> $out_db
#
# ************************************************** create outpuf generic db file **************************************************
