#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="onco_array_2"
project_out_dir="/proj/b2011117/private/projects/out/db/ta_$dataset_name"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Oncoarray/vcf/chr9/9q_7_oncoarray.vcf.gz"
#vcf_region=6
project_code="b2011097"
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
