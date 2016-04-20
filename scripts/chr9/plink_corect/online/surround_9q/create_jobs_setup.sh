#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="oncochip_n_twin_chr9"
project_out_dir="$PLINK_OUTPUT_DIR/chr9/online/surround_9q"
project_code="b2011097"
jobs_setup_file="$dataset_name"_jobs_setup.txt
#input_dna_regions="9:100911000-100946000"
input_dna_regions="9"
hap_window_sizes="1,3,5,10,25"
input_bfile_prefix="$GENOTYPING_ONCOCHIP_N_TWINGENE"
phenotype_file="$GENOTYPING_ONCOCHIP_N_TWINGENE_PHENOTYPE_FILE"
filter_criteria="PVALUE005"
filter_criteria+=",DISEASE_SNP"


cmd="pyCMM-plink-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
if [ ! -z $hap_window_sizes ]
then
    cmd+=" --hap-window $hap_window_sizes"
fi
if [ ! -z $input_bfile_prefix ]
then
    cmd+=" --bfile $input_bfile_prefix"
fi
if [ ! -z $input_file_prefix ]
then
    cmd+=" --file $input_file_prefix"
fi
cmd+=" --pheno $phenotype_file"
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $input_dna_regions ]
then
    cmd+=" -R $input_dna_regions"
fi
if [ ! -z $filter_criteria ]
then
    cmd+=" --filter_criteria $filter_criteria"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
