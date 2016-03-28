#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="Axeq_chr9"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/standard/$dataset_name/"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Axeq_b2012247/Axeq_chr9.vcf.gz"
vcf_region="9"
project_code="b2011097"
annotated_vcf_tabix="$ANNOTATED_AXEQ_CHR9"
report_regions="9"
call_info="True"
#split_chrom=True
#freq_ratios="ExAC_ALL:0.1"
jobs_setup_file="mutrep_$dataset_name"_jobs_setup.txt


cmd="pyCMM-cmmdb-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
cmd+=" -i $vcf_tabix_file"
if [ ! -z $vcf_region ]
then
    cmd+=" -r $vcf_region"
fi
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
if [ "$summary_families" = "True" ]
then
    cmd+=" --summary_families"
fi
if [ "$only_families" = "True" ]
then
    cmd+=" --only_families"
fi
if [ "$only_summary" = "True" ]
then
    cmd+=" --only_summary"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
