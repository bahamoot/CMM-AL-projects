#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

project_code="b2011117"
dataset_name="sv_colon_extra"
tabix_file=$CMM_UPPSALA_50FAM_ALL_PATIENTS_GZ
working_dir=$CMM_PROJECTS_WORKING_DIR

project_name="sanna_n_vinay"
sub_project_name="colon_extra"

col_names="Co90,Co89,Co135,Co131,Co700,Co454,1526-02D,Co1301,Co616,Co1156,Co837,Co840,Co1053,1104-03D,Co866,Co1031,Co1037,Co1051,Co1534,468-04,354-06"
vcf_region="6:38704942-44147822" #rs6935293-rs34710081
#vcf_region+=",5:673407-673408" #rs413666
#vcf_region+=",5:4835204-4835205" #rs816480
#vcf_region+=",9:92903714-92903715" #rs7037744
#vcf_region+=",14:86179620-86179621" #rs981270
#vcf_region+=",X:8607364-8607365" #rs1159561

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
gt_vcf_gt_out_file=$out_dir/$dataset_name.gt.vgt
mt_vcf_gt_out_file=$out_dir/$dataset_name.mt.vgt
sa_out_file=$out_dir/$dataset_name.sa

cmd="$SCRIPT_GEN_DEFAULT_DATA -p $project_code -N $dataset_name -t $tabix_file -w $working_dir"
if [ ! -z "$oaf_out_file" ]; then
    cmd+=" -O $oaf_out_file"
fi
if [ ! -z "$gt_vcf_gt_out_file" ]; then
    cmd+=" -G $gt_vcf_gt_out_file"
fi
if [ ! -z "$mt_vcf_gt_out_file" ]; then
    cmd+=" -M $mt_vcf_gt_out_file"
fi
if [ ! -z "$sa_out_file" ]; then
    cmd+=" -S $sa_out_file"
fi
if [ ! -z "$vcf_region" ]; then
    cmd+=" -R $vcf_region"
fi
if [ ! -z "$col_names" ]; then
    cmd+=" -c $col_names"
fi
eval $cmd


