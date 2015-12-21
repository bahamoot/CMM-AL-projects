#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ************************************************** defining raw data position **************************************************
raw_dir="$script_dir/raw"

onco_array_dir="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/"
onco_array_bin_prefix="$onco_array_dir/corect_oncoarray_quality-controlled_genotypes_v1_2015-10-22_SWEDEN-Lindblom"

#fam24_haplo_dir="/glob/jessada/private/master_data/CMM/haplotype/fam24/"
#fam24_haplo_bin_prefix="$fam24_haplo_dir/Haplotype_fam24"
#
#onco_array_bin_prefix="$fam24_haplo_bin_prefix"

ref_dir="/glob/jessada/tools/annovar/humandb/"
ref_file="$ref_dir/hg19_ALL.sites.2014_10.txt"
#ref_file="$ref_dir/hg19_tmp_onco_array.txt"

tmp_dir="$script_dir/../tmp"
tmp_plink_snp="$tmp_dir/onco_array_plink_snp"
tmp_snp="$tmp_dir/onco_array_snp.txt"
tmp_coor="$tmp_dir/onco_array_coor.txt"

out_dir="$script_dir/../out"
out_onco_array_vcf_file="$out_dir/onco_array.vcf"

# ************************************************** defining raw data position **************************************************

# ************************************************** extract snps **************************************************
#plink_cmd="plink --noweb --bfile $onco_array_bin_prefix --recode --out $tmp_plink_snp"
#eval $plink_cmd
#
#map2snp_cmd="cut -f2 $tmp_plink_snp.map > $tmp_snp"
#eval $map2snp_cmd
# ************************************************** extract snps **************************************************

# ************************************************** create vcf **************************************************
#join_cmd="join -t $'\t' -1 1 -2 6 -o 2.1,2.2,2.3,2.4 <( sort $tmp_snp ) <( sort -k6,6 $ref_file ) | sort -n -k2,2 > $tmp_coor"
#eval $join_cmd

echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO" > $out_onco_array_vcf_file
awk_cmd_pipe=" | awk -F'\t' '{ printf \"%s\t%s\t\t%s\t%s\t\t\t%s\n\", \$1, \$2, \$3, \$4, \".\" }' >> $out_onco_array_vcf_file"

coor2vcf_cmd=" grep '^[0-9]' $tmp_coor | sort -n -k1,1 -k2,2"
coor2vcf_cmd+="$awk_cmd_pipe"
eval "$coor2vcf_cmd"

coor2vcf_cmd=" grep -v '^[0-9]' $tmp_coor | sort -k1,1 -k2,2n"
coor2vcf_cmd+="$awk_cmd_pipe"
eval "$coor2vcf_cmd"



#cat $out_onco_array_vcf_file
# ************************************************** create vcf **************************************************
