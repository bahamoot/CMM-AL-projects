#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="debug_WES"
project_out_dir="$MUTSTAT_OUTPUT_DIR/WES/cal_stat_$dataset_name"
vcf_tabix_file="$VCF_WES294"
db_region="1:10400-10700"
sample_info="$SAMPLES_LIST_DIR/Exome_OAF_BrC.list"
#sample_info="/glob/jessada//private/master_data/CMM/family/processed/uppsala//uppsala_pats_all_members.lst.all"
#project_code="b2011097"
jobs_setup_file=cal_mut_stat_"$dataset_name"_jobs_setup.txt


cmd="pyCMM-cmmdb-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
cmd+=" -i $vcf_tabix_file"
if [ ! -z $db_region ]
then
    cmd+=" -r $db_region"
fi
if [ ! -z $sample_info ]
then
    cmd+=" -s $sample_info"
fi
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
