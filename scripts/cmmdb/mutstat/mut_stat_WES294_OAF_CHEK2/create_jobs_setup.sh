#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="OAF_CHEK2"
project_out_dir="$MUTSTAT_OUTPUT_DIR/WES/cal_stat_$dataset_name"
vcf_tabix_file="$VCF_WES294_WO_STAR"
sample_info="$SAMPLES_LIST_DIR/Exome_OAF_CHEK2.list"
#sample_info="/glob/jessada//private/master_data/CMM/family/processed/uppsala//uppsala_pats_all_members.lst.all"
project_code="b2016331"
vcf2avdb_key_table="$VCF2AVDB_WES294"
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
if [ ! -z $vcf2avdb_key_table ]
then
    cmd+=" -t $vcf2avdb_key_table"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
