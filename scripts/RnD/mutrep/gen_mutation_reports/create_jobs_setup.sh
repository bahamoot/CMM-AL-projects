#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="gen_mutation_reports"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/RnD/$dataset_name"
#project_code="b2012247"
annotated_vcf_tabix="$ANNOTATED_WES294"
#annotated_vcf_tabix="$ANNOTATED_AXEQ_CHR3_6_14_18"
call_detail="True"
#sample_infos="$script_dir/gen_mutation_reports.sample_infos"
sample_infos="$SAMPLES_LIST_DIR/Exome_all_samples.list"
report_regions="6:78171941-78172992,18:28610988-28611790"
#only_families="True"
#freq_ratios="ExAC_ALL:0.1"
jobs_setup_file="$dataset_name"_jobs_setup.txt
summary_families="True"

cmd="pyCMM-mutrep-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $annotated_vcf_tabix ]
then
    cmd+=" -A $annotated_vcf_tabix"
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
if [ "$summary_families" == "True" ]
then
    cmd+=" --summary_families"
fi
if [ "$exclude_common" = "True" ]
then
    cmd+=" --exclude_common"
fi
if [ ! -z $sample_infos ]
then
    cmd+=" -s $sample_infos"
fi
if [ "$only_summary" = "True" ]
then
    cmd+=" --only_summary"
fi
if [ "$only_families" = "True" ]
then
    cmd+=" --only_families"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
