#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

script_gen_dafault_data=$script_dir/script_gen_default_data.sh

source ~/.bashrc

project_code="b2011158"
dataset_name="scilife_illumina"
tabix_file=$CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_MANS_GZ
working_dir=$CMM_PROJECTS_WORKING_DIR

oaf_out_file=$CMM_OAF_SCILIFE_ILLUMINA_ALL_FAM
genotyped_vcf_gt_out_file=$CMM_SCILIFE_ILLUMINA_GENOTYPED_VCF_GT
mutated_vcf_gt_out_file=$CMM_SCILIFE_ILLUMINA_MUTATED_VCF_GT
summarize_annovar_out_file=$CMM_SCILIFE_ILLUMINA_UPPSALA_SA_DB

$script_gen_dafault_data -p $project_code -N $dataset_name -t $tabix_file -O $oaf_out_file -G $genotyped_vcf_gt_out_file -M $mutated_vcf_gt_out_file -S $summarize_annovar_out_file -w $working_dir


