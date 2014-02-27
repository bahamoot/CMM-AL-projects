#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

project_code="b2011117"
dataset_name="sv_rectal_extra"
tabix_file=$CMM_UPPSALA_50FAM_ALL_PATIENTS_GZ
working_dir=$CMM_PROJECTS_WORKING_DIR

project_name="sanna_n_vinay"
sub_project_name="rectal_extra"

col_names="Co35,Co37,Co238,Co367,Co446,Co555,Co572,Co1262,Co618,Co793,Co876,Co1116,Co851,Co859,Co846,Co857,Co1458,Co1595,Co1274,Co1207,Co1302,Co1322,Co1583,Co1584,Co1349,531-04o,Co1467,529-05,Co1373,602-05o,Co1383,134-06,354-06,Co1538,642-06,1052-05,Co1301"
vcf_region="18:9944959-19996806" #rs29132-rs12961009
#vcf_region+=",9:101331391-101331392" #rs1167768

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


