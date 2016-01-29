#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="Axeq_chr5_19"
project_out_dir="/proj/b2011117/private/projects/out/db/cal_stat_$dataset_name"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Axeq_b2012247/Axeq_chr5_19.vcf.gz"
#sample_infos="/glob/jessada//private/master_data/CMM/family/processed/uppsala//uppsala_pats_all_members.lst.COLON"
project_code="b2011097"
jobs_setup_file=cal_mut_stat_"$dataset_name"_jobs_setup.txt


cmd="pyCMM-cmmdb-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
cmd+=" -i $vcf_tabix_file"
if [ ! -z $sample_infos ]
then
    cmd+=" -c $sample_infos"
fi
cmd+=" -p $project_code"
cmd+=" -o $jobs_setup_file"

eval "$cmd"
