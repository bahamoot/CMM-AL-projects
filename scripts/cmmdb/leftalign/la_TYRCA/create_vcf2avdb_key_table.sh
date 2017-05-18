#!/bin/bash

module load annovar
 
input_vcf_gz=$1
dataset_name=$2
output_key_table=$3

source $PYCMM/bash/cmm_functions.sh
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

data_dir="$script_dir/../data/"

tmp_dir="$script_dir/../tmp/"

out_dir="$script_dir/../out/"

##annovar_root_dir="$JESSADA_GLOB/tools/annovar"
#
##dataset_name="Ill_Br"
##dataset_name="101CRC_all"
##dataset_name="101CRC_CAFAM"
##dataset_name="101CRC_CRC"
##dataset_name="101CRC_COLON"
##dataset_name="101CRC_RECTAL"
##dataset_name="Axeq_chr3_6_14_18"
##dataset_name="Axeq_chr5_19"
##dataset_name="OAF_BrCs"
#dataset_name="OAF_familial_CRCs"
##dataset_name="OAF_CRCs"
##dataset_name="OAF_CHEK2"
##dataset_name="OAF_BrC_CRC_prostate"
##dataset_name="OAF_EARLYONSET"
##dataset_name="Axeq_chr9"
##dataset_name="Axeq_chr9"
##dataset_name="PMS2_sporadic_fam24"
##input_vcf_gz="/glob/jessada//private/master_data/CMM/CMM_Scilife_b2011158//vcf/Ill_Br_Fam242.vcf.gz"
##input_vcf_gz="/glob/jessada/private/master_data/CMM/CMM_Axeq_b2012247//Axeq_chr3_6_14_18.vcf.gz"
##input_vcf_gz="/glob/jessada/private/master_data/CMM/CMM_Axeq_b2012247//Axeq_chr5_19.vcf.gz"
#input_vcf_gz="$VCF_WES294"
##input_vcf_gz="/glob/jessada/private/master_data/CMM/CMM_Axeq_b2012247//Axeq_chr9.vcf.gz"
##input_vcf_gz="/glob/jessada/private/master_data/CMM/CMM_Uppsala_b2011117/Uppsala_realigned_58_families.vcf.gz"
##input_vcf_gz="/glob/jessada/private/master_data/CMM/CMM_Uppsala_b2011117/NK64_PMS2_sporadic_fam24.vcf.gz"
##raw_stat_folder="/proj/b2011117/private/projects/out/db/cal_stat_$dataset_name/data_out"
#raw_stat_folder="$MUTSTAT_OUTPUT_DIR/WES/cal_stat_$dataset_name/data_out"
#out_stat_folder="$script_dir/../"
#tmp_dir="$script_dir/../tmp"

tmp_vcf_query=$tmp_dir/$dataset_name"_tmp_vcf_query"
avinput_file_prefix=$tmp_dir/$dataset_name"_avdb_individual"
tmp_avdb_uniq=$tmp_dir/$dataset_name"_tmp_uniq.avdb"
avdb_uniq=$tmp_dir/$dataset_name".uniq.avdb"
#avdb_key=$tmp_dir/$dataset_name".key.avdb"
#
#IDX_0_GT_COL=9

#---------- vcf2avdb --------------
#generate query header
query_header="#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT"
#header_rec=$( zgrep "^#C" $input_vcf_gz )
#IFS=$'\t' read -ra col_list <<< "$header_rec"
#for (( i=$IDX_0_GT_COL; i<$((${#col_list[@]})); i++ ))
#do
#	query_header+="\t${col_list[$i]}"
#done
query_header+="\tdummy1\tdummy2\tdummy3"
echo -e "$query_header" > $tmp_vcf_query

vcf_query_cmd="vcf-query "
vcf_query_cmd+=" -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\t%QUAL\t%FILTER\t%INFO\tGT\t1/2\t3/4\t5/6\n'"
vcf_query_cmd+=" $input_vcf_gz"
vcf_query_cmd+=" >> $tmp_vcf_query"
eval_cmd "$vcf_query_cmd"



rm $avinput_file_prefix*
convert2annovar="convert2annovar.pl -format vcf4 $tmp_vcf_query -include --allsample --outfile $avinput_file_prefix"
eval_cmd "$convert2annovar" 

:>$tmp_avdb_uniq
for f in $avinput_file_prefix*
do
    concat_avdb_cmd="cut -f1-11 $f >> $tmp_avdb_uniq"
    eval_cmd "$concat_avdb_cmd" 
done

sort $tmp_avdb_uniq | uniq > $avdb_uniq
#---------- vcf2avdb --------------

#---------- rearrange avdb and add key --------------
:>$output_key_table
add_key_to_avdb="grep -P \"^[0-9]\" $avdb_uniq"
add_key_to_avdb+=" | awk -F'\t' '{ printf \"%02d_%012d_%s_%s\t%s\t%s\t%s\t%s\t%s\n\", \$6, \$7, \$9, \$10, \$1, \$2, \$3, \$4, \$5 }'"
add_key_to_avdb+=" >> $output_key_table"
eval_cmd "$add_key_to_avdb"
add_key_to_avdb="grep -vP \"^[0-9]\" $avdb_uniq"
add_key_to_avdb+=" | awk -F'\t' '{ printf \"%s_%012d_%s_%s\t%s\t%s\t%s\t%s\t%s\n\", \$6, \$7, \$9, \$10, \$1, \$2, \$3, \$4, \$5 }'"
add_key_to_avdb+=" >> $output_key_table"
eval_cmd "$add_key_to_avdb"
#---------- rearrange avdb and add key --------------

##---------- generate stat key --------------
#tmp_stat_key=$tmp_dir/$dataset_name"_tmp_key.stat"
#stat_sort=$tmp_dir/$dataset_name"_sort.key.stat"
#:>$tmp_stat_key
#for stat_file in $raw_stat_folder/*.stat
#do
#    add_key_to_stat="grep -P \"^[0-9]\" $stat_file | awk -F'\t' '{ printf \"%02d_%012d_%s_%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$4, \$5, \$6,  \$7,  \$8,  \$9,  \$10,  \$11,  \$12,  \$13,  \$14  }'"
#    eval_cmd "$add_key_to_stat" "$tmp_stat_key" ""
#    add_key_to_stat="grep -vP \"^[0-9]\" $stat_file | awk -F'\t' '{ printf \"%s_%012d_%s_%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$4, \$5, \$6,  \$7,  \$8,  \$9,  \$10,  \$11,  \$12,  \$13,  \$14 }'"
#    eval_cmd "$add_key_to_stat" "$tmp_stat_key" ""
#done
#:>$stat_sort
#stat_sort_cmd="sort -k1,1 $tmp_stat_key"
#eval_cmd "$stat_sort_cmd" "$stat_sort" ""
##---------- generate stat key --------------
#
##---------- reformat stat --------------
#raw_stat_file="$tmp_dir/raw_hg19_CMM_$dataset_name.txt"
#
#:>$raw_stat_file
#join_cmd="join -t $'\t' -j 1 -o 1.2,1.3,1.4,1.5,1.6,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,2.10 <( sort -k1,1 $avdb_key ) $stat_sort"
#eval_cmd "$join_cmd" "$raw_stat_file" ""
##---------- reformat stat --------------
#
##---------- write stat file --------------
#out_stat_file="$out_stat_folder/hg19_CMM_$dataset_name.txt"
#
#col_prefix=$( echo $dataset_name | sed 's/WES294_//g' | awk '{print toupper($0)}' )
##echo $col_prefix
#stat_header="#Chr"
#stat_header+="\tStart"
#stat_header+="\tEnd"
#stat_header+="\tRef"
#stat_header+="\tAlt"
#stat_header+="\t$col_prefix"_WT
#stat_header+="\t$col_prefix"_HET
#stat_header+="\t$col_prefix"_HOM
#stat_header+="\t$col_prefix"_OTH
#stat_header+="\t$col_prefix"_NA
#stat_header+="\t$col_prefix"_GT
#stat_header+="\t$col_prefix"_GF
#stat_header+="\t$col_prefix"_AF
#stat_header+="\t$col_prefix"_PF
#echo -e "$stat_header" > $out_stat_file
#cat "$raw_stat_file" >> $out_stat_file
##---------- write  stat file --------------
#
##---------- idx stat file --------------
#idx_stat_file="$out_stat_folder/hg19_CMM_$dataset_name.txt.idx"
#idx_cmd="$script_dir/compileAnnnovarIndex.pl"
#idx_cmd+=" $raw_stat_file"
#idx_cmd+=" 1000"
#
#:>$idx_stat_file
#eval_cmd "$idx_cmd" "$idx_stat_file" ""
##---------- idx stat file --------------
