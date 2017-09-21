#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="chr9_bert"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/chr9/$dataset_name/"
job_alloc_time="2-10:00:00"
project_code="b2012247"

##anno_excl_tags="Axeq_chr5_19,Axeq_chr3_6_14_18,CRC_101,Mutstat_details,LJB_score"
##rows_filter="Rare"
##rows_filter+=",Non-Intergenic"
##rows_filter+=",Non-Intronic"
##rows_filter+=",Has-Mutation"
##rows_filter+=",Has-Shared"
annotated_vcf_tabix="$ANNOTATED_BERT"
#sample_infos="24:Co-166:Co-648"
##sample_infos="Co-166,Co-213,Co-648,Co-37,Co-618,Co-1274"
#report_regions="9:98307129-105545039"
#call_detail="True"
##split_chrom=True
##summary_families=True
##only_families=True
##only_summary=True
##freq_ratios="ExAC_ALL:0.1"
jobs_setup_file="$dataset_name"_jobs_setup.txt


cmd="pyCMM-mutrep-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $job_alloc_time ]
then
    cmd+=" --job_alloc_time $job_alloc_time"
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
