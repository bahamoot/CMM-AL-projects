#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="TYRCA"
project_out_dir="$TABLE_ANNOVAR_OUTPUT_DIR/ta_$dataset_name"
vcf_tabix_file="$VCF_TYRCA"
#vcf_region=6
project_code="b2016200"
jobs_setup_file="ta_$dataset_name"_jobs_setup.txt


cmd="pyCMM-cmmdb-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
cmd+=" -i $vcf_tabix_file"
if [ ! -z "$vcf_region" ]
then
    cmd+=" -r $vcf_region"
fi
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
