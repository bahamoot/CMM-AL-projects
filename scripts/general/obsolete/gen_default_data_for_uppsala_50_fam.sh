#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

project_code="b2011117"
dataset_name="uppsala_50_fam"
tabix_file=$CMM_UPPSALA_50FAM_ALL_PATIENTS_GZ
working_dir=$CMM_PROJECTS_WORKING_DIR

oaf_out_file=$CMM_OAF_UPPSALA_REALIGNED_ALL_50FAM
genotyped_vcf_gt_out_file=$CMM_UPPSALA_50FAM_GENOTYPED_VCF_GT
mutated_vcf_gt_out_file=$CMM_UPPSALA_50FAM_MUTATED_VCF_GT
summarize_annovar_out_file=$CMM_UPPSALA_REALIGNED_50FAM_SA_DB

$SCRIPT_GEN_DEFAULT_DATA -p $project_code -N $dataset_name -t $tabix_file -O $oaf_out_file -G $genotyped_vcf_gt_out_file -M $mutated_vcf_gt_out_file -S $summarize_annovar_out_file -w $working_dir


