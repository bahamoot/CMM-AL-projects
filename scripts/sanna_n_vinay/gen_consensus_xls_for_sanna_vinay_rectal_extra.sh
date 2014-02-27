#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

dataset_name="sv_rectal_extra"
working_dir=$CMM_PROJECTS_WORKING_DIR

project_name="sanna_n_vinay"
sub_project_name="rectal_extra"

#vcf_region="9:92298000-105323000"

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

oaf_in_file=$out_dir/$dataset_name.oaf
#gt_vcf_gt_in_file=$out_dir/$dataset_name.gt.vgt
mt_vcf_gt_in_file=$out_dir/$dataset_name.mt.vgt
sa_in_file=$out_dir/$dataset_name.sa


cmd="$SCRIPT_GEN_CONSENSUS_XLS -k $dataset_name -O $oaf_in_file -S $sa_in_file -w $working_dir -o $out_dir"
if [ ! -z "$gt_vcf_gt_in_file" ]; then
    cmd+=" -G $gt_vcf_gt_in_file"
fi
if [ ! -z "$mt_vcf_gt_in_file" ]; then
    cmd+=" -M $mt_vcf_gt_in_file"
fi

eval $cmd


