#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="mutation_linkage_chrX"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/linkage/chr_x"
project_code="b2012247"
annotated_vcf_tabix="$ANNOTATED_WES294"
sample_infos="$script_dir/samples.list"
anno_excl_tags="Mutstat_details"
anno_excl_tags+=",ExAC_Other"
anno_excl_tags+=",Axeq_chr3_6_14_18"
anno_excl_tags+=",Axeq_chr5_19"
anno_excl_tags+=",Axeq_chr9"
anno_excl_tags+=",WES294_CHEK2"
anno_excl_tags+=",WES294_EARLYONSET"
anno_excl_tags+=",LJB_score"
anno_excl_tags+=",Unknown"
report_regions="X:68196437-88365553"
show_shared_variants="True"
#call_info="True"
split_chrom=False
#filter_actions="Rare"
#filter_actions+=",Non-Intergenic"
#filter_actions+=",Non-Intronic"
filter_actions="Has-Mutation"
#filter_actions+=",Has-Shared"
#freq_ratios="ExAC_ALL:0.1"
jobs_setup_file="$dataset_name"_jobs_setup.txt
#only_families="True"
#only_summary="True"

cmd="pyCMM-mutrep-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $anno_excl_tags ]
then
    cmd+=" -E $anno_excl_tags"
fi
if [ ! -z "$filter_actions" ]
then
    cmd+=" --filter_actions $filter_actions"
fi
if [ ! -z $annotated_vcf_tabix ]
then
    cmd+=" -A $annotated_vcf_tabix"
fi
if [ ! -z $sample_infos ]
then
    cmd+=" -s $sample_infos"
fi
if [ ! -z $report_regions ]
then
    cmd+=" -R $report_regions"
fi
if [ "$call_detail" == "True" ]
then
    cmd+=" --call_detail"
fi
if [ ! -z $freq_ratios ]
then
    cmd+=" -f $freq_ratios"
fi
if [ "$split_chrom" == "True" ]
then
    cmd+=" --split_chrom"
fi
if [ "$show_shared_variants" == "True" ]
then
    cmd+=" --show_shared_variants"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
