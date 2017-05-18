#!/bin/bash

input_vcf_gz=$1
output_vcf=$2

source $PYCMM/bash/cmm_functions.sh

working_dir=`mktemp -d`
tmp_decompose_input_vcf="$working_dir/tmp_decompose_input.vcf"
tmp_left_align_input_vcf="$working_dir/tmp_left_align_input.vcf"
tmp_annovar_db="$working_dir/tmp_annovar_db.txt"

function decompose_n_leftalign {
    chrom=$1
    # decompose and leftalign input vcf
    cmd="tabix -h"
    cmd+=" $input_vcf_gz"
    cmd+=" $chrom"
    cmd+=" | vt decompose -s -"
    cmd+=" | vt normalize -r $GRCH37_REF -"
    cmd+=" | grep -v \"^#\""
    cmd+=" >> $output_vcf"
    eval_cmd "$cmd"
}

tabix -h $input_vcf_gz 1:1-1 > $output_vcf
decompose_n_leftalign 1
decompose_n_leftalign 2
decompose_n_leftalign 3
decompose_n_leftalign 4
decompose_n_leftalign 5
decompose_n_leftalign 6
decompose_n_leftalign 7
decompose_n_leftalign 8
decompose_n_leftalign 9
decompose_n_leftalign 10
decompose_n_leftalign 11
decompose_n_leftalign 12
decompose_n_leftalign 13 
decompose_n_leftalign 14
decompose_n_leftalign 15
decompose_n_leftalign 16
decompose_n_leftalign 17
decompose_n_leftalign 18
decompose_n_leftalign 19
decompose_n_leftalign 20
decompose_n_leftalign 21
decompose_n_leftalign 22
decompose_n_leftalign "X"
decompose_n_leftalign "Y"

## decompose input vcf
#cmd="zless"
#cmd+=" $input_vcf_gz"
#cmd+=" | vt decompose -s -"
#cmd+=" > $tmp_decompose_input_vcf"
#eval_cmd "$cmd"
#
## leftalign input vcf
#cmd="java -jar $GATK_dir/GenomeAnalysisTK.jar"
#cmd+=" -T LeftAlignAndTrimVariants"
#cmd+=" -R $GRCH37_REF"
#cmd+=" --variant $tmp_decompose_input_vcf"
#cmd+=" > $tmp_left_align_input_vcf"
#eval_cmd "$cmd"

## leftalign input vcf
#cmd="bcftools norm"
#cmd+=" -f $GRCH37_REF"
#cmd+=" -o $tmp_left_align_input_vcf"
#cmd+=" $tmp_decompose_input_vcf"
#eval_cmd "$cmd"
#
#bgzip -f $tmp_left_align_input_vcf
#tabix -f -p vcf $tmp_left_align_input_vcf.gz
#
## convert allele frequency into annovar format
#cmd="$PYCMM/bash/vcf_AF_to_annovar.sh"
#cmd+=" -k $dataset_name"
#cmd+=" -i $tmp_left_align_input_vcf.gz"
#cmd+=" -r 2"
#cmd+=" -o $tmp_annovar_db"
#eval_cmd "$cmd"
#
### parse the position to avdb format
##cmd="$JESSADA_GLOB/private/projects/correct_mut_stat/bin/swegen2mutstat"
##cmd+=" $tmp_annovar_db"
##cmd+=" $dataset_name"
##eval_cmd "$cmd"
#
##---------- vcf2avdb --------------
##generate query header
#query_header="#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT"
#header_rec=$( zgrep "^#C" $vcf_tabix_file )
#IFS=$'\t' read -ra col_list <<< "$header_rec"
#for (( i=$IDX_0_GT_COL; i<$((${#col_list[@]})); i++ ))
#do
#	query_header+="\t${col_list[$i]}"
#done
#query_header+="\tdummy1\tdummy2\tdummy3"
#echo -e "$query_header" > $tmp_vcf_query
#
#function run_vcf_query {
#    
#    region=$1
#
#    vcf_query_cmd="vcf-query "
#    vcf_query_cmd+=" -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\t%QUAL\t%FILTER\t%INFO\tGT\t1/2\t3/4\t5/6\n' $vcf_tabix_file"
#    eval_cmd "$vcf_query_cmd" "$tmp_vcf_query" "generating vcf genotyping using data from"
#} 
