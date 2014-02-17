#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

project_code="b2012247"
dataset_name="chr9_linkage_axeq"
tabix_file=$CMM_AXEQ_CHR9_ALL_PATIENTS_GZ
working_dir=$CMM_PROJECTS_WORKING_DIR

project_name="chr9_linkage"
sub_project_name="axeq"

vcf_region="9:92298000-105323000"
col_names="Co37,Co618,Co1274,Co876"

if [ ! -d "$CMM_PROJECTS_OUTPUT_DIR/$project_name" ]; then
    mkdir "$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi
if [ ! -z "$sub_project_name" ]; then
    out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
    if [ ! -d "$out_dir" ]; then
        mkdir "$out_dir"
    fi
else
    out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi

oaf_out_file=$out_dir/$dataset_name.oaf
genotyped_vcf_gt_out_file=$out_dir/$dataset_name.gt.vgt
mutated_vcf_gt_out_file=$out_dir/$dataset_name.mt.vgt
summarize_annovar_out_file=$out_dir/$dataset_name.sa

$SCRIPT_GEN_DEFAULT_DATA -p $project_code -N $dataset_name -t $tabix_file -O $oaf_out_file -G $genotyped_vcf_gt_out_file -M $mutated_vcf_gt_out_file -S $summarize_annovar_out_file -w $working_dir -R $vcf_region -c $col_names


