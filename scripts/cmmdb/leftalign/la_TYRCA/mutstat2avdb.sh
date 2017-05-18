#!/bin/bash

mutstat_file=$1
vcf2avdb_key_table=$2
dataset_name=$3
out_avdb=$4

source $PYCMM/bash/cmm_functions.sh
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

data_dir="$script_dir/../data/"

tmp_dir="$script_dir/../tmp/"
#tmp_decompose_input_vcf="$tmp_dir/tmp_decompose_input.vcf"
#tmp_left_align_input_vcf="$tmp_dir/tmp_left_align_input.vcf"
#tmp_annovar_db="$tmp_dir/tmp_annovar_db.txt"
out_dir="$script_dir/../out/"

#---------- generate stat key --------------
function create_tmp_stat_key {
    mutstat_file=$1
    tmp_stat_key=$2

    add_key_to_stat="grep -P \"^[0-9]\" $mutstat_file"
    add_key_to_stat+=" | awk -F'\t' '{ printf \"%02d_%012d_%s_%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$4, \$5, \$6,  \$7,  \$8,  \$9,  \$10,  \$11,  \$12,  \$13,  \$14  }'"
    add_key_to_stat+=" >> $tmp_stat_key"
    eval_cmd "$add_key_to_stat"
    add_key_to_stat="grep -vP \"^[0-9]\" $mutstat_file"
    add_key_to_stat+=" | awk -F'\t' '{ printf \"%s_%012d_%s_%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$4, \$5, \$6,  \$7,  \$8,  \$9,  \$10,  \$11,  \$12,  \$13,  \$14 }'"
    add_key_to_stat+=" >> $tmp_stat_key"
    eval_cmd "$add_key_to_stat"
}

tmp_stat_key=$tmp_dir/$dataset_name"_tmp_key.stat"
stat_sort=$tmp_dir/$dataset_name"_sort.key.stat"
:>$tmp_stat_key
create_tmp_stat_key $mutstat_file $tmp_stat_key
#for stat_file in $raw_stat_folder/*.stat
#do
#    add_key_to_stat="grep -P \"^[0-9]\" $stat_file | awk -F'\t' '{ printf \"%02d_%012d_%s_%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$4, \$5, \$6,  \$7,  \$8,  \$9,  \$10,  \$11,  \$12,  \$13,  \$14  }'"
#    eval_cmd "$add_key_to_stat" "$tmp_stat_key" ""
#    add_key_to_stat="grep -vP \"^[0-9]\" $stat_file | awk -F'\t' '{ printf \"%s_%012d_%s_%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n\", \$1, \$2, \$4, \$5, \$6,  \$7,  \$8,  \$9,  \$10,  \$11,  \$12,  \$13,  \$14 }'"
#    eval_cmd "$add_key_to_stat" "$tmp_stat_key" ""
#done
:>$stat_sort
stat_sort_cmd="sort -k1,1 $tmp_stat_key >> $stat_sort"
eval_cmd "$stat_sort_cmd"
#---------- generate stat key --------------

#---------- reformat stat --------------
raw_stat_file="$tmp_dir/raw_hg19_CMM_$dataset_name.txt"

:>$raw_stat_file
join_cmd="join -t $'\t' -j 1 -o 1.2,1.3,1.4,1.5,1.6,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,2.10 <( sort -k1,1 $vcf2avdb_key_table ) $stat_sort >> $raw_stat_file"
eval_cmd "$join_cmd"
#---------- reformat stat --------------

#---------- write stat file --------------
#out_stat_file="$out_stat_folder/hg19_CMM_$dataset_name.txt"

col_prefix=$( echo $dataset_name | sed 's/WES294_//g' | awk '{print toupper($0)}' )
#echo $col_prefix
stat_header="#Chr"
stat_header+="\tStart"
stat_header+="\tEnd"
stat_header+="\tRef"
stat_header+="\tAlt"
stat_header+="\t$col_prefix"_WT
stat_header+="\t$col_prefix"_HET
stat_header+="\t$col_prefix"_HOM
stat_header+="\t$col_prefix"_OTH
stat_header+="\t$col_prefix"_NA
stat_header+="\t$col_prefix"_GT
stat_header+="\t$col_prefix"_GF
stat_header+="\t$col_prefix"_AF
stat_header+="\t$col_prefix"_PF
echo -e "$stat_header" > $out_avdb
cat "$raw_stat_file" >> $out_avdb
#---------- write  stat file --------------

#---------- idx stat file --------------
#idx_stat_file="$out_stat_folder/hg19_CMM_$dataset_name.txt.idx"
idx_stat_file="$out_avdb.idx"
idx_cmd="$PYCMM/bash/compileAnnnovarIndex.pl"
idx_cmd+=" $raw_stat_file"
idx_cmd+=" 1000"
idx_cmd+=" >> $idx_stat_file"

:>$idx_stat_file
eval_cmd "$idx_cmd"
#---------- idx stat file --------------
