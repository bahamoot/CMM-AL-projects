#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="Ill_Br"
project_out_dir="/proj/b2011117/private/projects/out/db/cal_stat_$dataset_name"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Scilife_b2011158/vcf/Ill_Br_Fam242.vcf.gz"
patients_list="/glob/jessada/private/master_data/CMM/family/processed/Ill_Br/Ill_Br.lst"
project_code="b2011158"
jobs_setup_file=cal_mut_stat_"$dataset_name"_jobs_setup.txt


cmd="pyCMM-mutrep-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
cmd+=" -i $vcf_tabix_file"
cmd+=" -c $patients_list"
cmd+=" -p $project_code"
cmd+=" -o $jobs_setup_file"

eval "$cmd"
