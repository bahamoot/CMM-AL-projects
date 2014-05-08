#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

project_name="RnD"
sub_project_name="test_plink_xls"

if [ ! -d "$CMM_PROJECTS_OUTPUT_DIR/$project_name" ]; then
    mkdir "$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi
if [ ! -z "$sub_project_name" ]; then
    out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
    dataset_name="$project_name"_"$sub_project_name"
    if [ ! -d "$out_dir" ]; then
        mkdir "$out_dir"
    fi
else
    out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
    dataset_name="$project_name"
fi


##********************************************* set parameters here *****************************************************
export PLINK_XLS_PROJECT_CODE="b2011117"
export PLINK_XLS_RUNNING_KEY=$dataset_name
export PLINK_XLS_PLINK_BIN_FILE_PREFIX=$CMM_GENOTYPING_UPPSALA_PROCESSED_PLINK_BIN_FILE_PREFIX
export PLINK_XLS_PLINK_PHENO_FILE="$script_dir/RnD_pheno.txt"
export PLINK_XLS_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
export PLINK_XLS_OUT_DIR=$out_dir
export PLINK_XLS_LOG_DIR=$CMM_PROJECTS_LOG_DIR

## vcf region from rs10124153 to rs7040414
export PLINK_XLS_PLINK_REGION="9:104030000-104060000"
#export PLINK_XLS_PHENOTYPE_FILE="9:104030000-104060000"

##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_PLINK_XLS
