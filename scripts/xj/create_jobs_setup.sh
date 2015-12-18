#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="xj_18q"
project_out_dir="/proj/b2011117/private/projects/out/xj/18q_axq/"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Axeq_b2012247/Axeq_chr3_6_14_18.vcf.gz"
vcf_region="6"
project_code="b2011158"
annotated_vcf_tabix="/glob/jessada/private/master_data/CMM/table_annovar/Axeq_chr3_6_14_18/Axeq_chr3_6_14_18_annotated.vcf.gz"
report_regions="18"
call_info="True"
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
if [ ! -z $annotated_vcf_tabix ]
then
    cmd+=" -A $annotated_vcf_tabix"
fi
if [ ! -z $report_regions ]
then
    cmd+=" -R $report_regions"
fi
if [ ! -z $call_info ]
then
    cmd+=" -C"
fi
if [ ! -z $freq_ratios ]
then
    cmd+=" -f $freq_ratios"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
