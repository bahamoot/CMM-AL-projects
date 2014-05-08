#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

script_gen_dafault_data=$script_dir/script_gen_default_data.sh

source ~/.bashrc

project_code="b2012247"
dataset_name="axeq_chr9"
tabix_file=$CMM_AXEQ_CHR9_ALL_PATIENTS_GZ
working_dir=$CMM_PROJECTS_WORKING_DIR

oaf_out_file=$CMM_OAF_AXEQ_CHR9_ALL_FAM
genotyped_vcf_gt_out_file=$CMM_AXEQ_CHR9_GENOTYPED_VCF_GT
mutated_vcf_gt_out_file=$CMM_AXEQ_CHR9_MUTATED_VCF_GT
summarize_annovar_out_file=$CMM_AXEQ_CHR9_SA_DB

$script_gen_dafault_data -p $project_code -N $dataset_name -t $tabix_file -O $oaf_out_file -G $genotyped_vcf_gt_out_file -M $mutated_vcf_gt_out_file -S $summarize_annovar_out_file -w $working_dir


