#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="gen_summary_report"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/RnD/$dataset_name"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Axeq_b2012247/Axeq_chr3_6_14_18.vcf.gz"
vcf_region="6"
project_code="b2012247"
db_alloc_time="120:00:00"
rpt_alloc_time="2-2:00:00"
anno_excl_tags="Axeq_chr5_19,Axeq_chr9,Mutstat_details,NK64,ExAC_Other,Unknown"
#annotated_vcf_tabix="/glob/jessada/private/master_data/CMM/table_annovar/Axeq_chr3_6_14_18/Axeq_chr3_6_14_18_annotated.vcf.gz"
annotated_vcf_tabix="$ANNOTATED_NK64_PMS2_EARLYONSET_FAM24"
call_detail="True"
filter_actions="Non-Intronic"
sample_infos="$CMM_CLIENT/scripts/RnD/gen_summary_report/gen_summary_report.sample_infos"
#freq_ratios="ExAC_ALL:0.1"
jobs_setup_file="$dataset_name"_jobs_setup.txt


cmd="pyCMM-cmmdb-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
cmd+=" -i $vcf_tabix_file"
cmd+=" -r $vcf_region"
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $db_alloc_time ]
then
    cmd+=" --db_alloc_time $db_alloc_time"
fi
if [ ! -z $rpt_alloc_time ]
then
    cmd+=" --rpt_alloc_time $rpt_alloc_time"
fi
if [ ! -z $anno_excl_tags ]
then
    cmd+=" -E $anno_excl_tags"
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
if [ ! -z $filter_actions ]
then
    cmd+=" --filter_actions $filter_actions"
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
if [ ! -z $sample_infos ]
then
    cmd+=" -s $sample_infos"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
