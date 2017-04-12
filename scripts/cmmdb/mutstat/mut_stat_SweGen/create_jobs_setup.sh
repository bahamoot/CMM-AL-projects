#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="SweGen"
project_out_dir="$MUTSTAT_OUTPUT_DIR/SweGen/first_release"
vcf_tabix_file="/proj/b2011117/private/databases/third_party/swegen/swegen_20161223/anon-SweGen_STR_NSPHS_1000samples_freq_hg19.vcf.gz"
job_alloc_time="4-14:00:00"
#sample_info="$SAMPLES_LIST_DIR/Exome_OAF_familial_CRC.list"
#sample_info="/glob/jessada//private/master_data/CMM/family/processed/uppsala//uppsala_pats_all_members.lst.all"
project_code="b2016331"
jobs_setup_file=cal_mut_stat_"$dataset_name"_jobs_setup.txt


cmd="pyCMM-cmmdb-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
cmd+=" -i $vcf_tabix_file"
if [ ! -z $sample_info ]
then
    cmd+=" -s $sample_info"
fi
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $job_alloc_time ]
then
    cmd+=" --job_alloc_time $job_alloc_time"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
