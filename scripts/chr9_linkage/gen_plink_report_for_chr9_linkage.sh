#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

project_name="chr9_lkg"
sub_project_name="plink"

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
export PLINK_REPORTS_RUNNING_KEY="$dataset_name"
export PLINK_REPORTS_PLINK_BIN_FILE_PREFIX="$CMM_GENOTYPING_UPPSALA_PROCESSED_PLINK_BIN_FILE_PREFIX"
export PLINK_REPORTS_PLINK_PHENO_FILE="$CMM_GENOTYPING_UPPSALA_COLON_300CTRLS_WO_RELATIVES_PHENO"
export PLINK_REPORTS_PLINK_HAP_WINDOW_SIZES="1,3,5,10,20,50,100"
export PLINK_REPORTS_PVALUE_SIGNIFICANCE_RATIO="2e-04"
export PLINK_REPORTS_USE_CACHED_PLINK_HAP_ASSOC="Off"
export PLINK_REPORTS_USE_CACHED_PLINK_EXTRA_INFO="Off"
export PLINK_REPORTS_WORKING_DIR="$CMM_PROJECTS_WORKING_DIR"
export PLINK_REPORTS_OUT_DIR="$out_dir"
export PLINK_REPORTS_LOG_DIR="$CMM_PROJECTS_LOG_DIR"

# PLINK region from chr9 linkage study is from rs4077800 to rs2000182
# rs4077800 = 9:92298167
# rs2000182 = 9:104792809
# PLINK region from chr9 fam24 study is from 9:97136378-105767702
# so combine two study
export PLINK_REPORTS_PLINK_REGION="9:92290000-105770000"
#export PLINK_REPORTS_PLINK_REGION="9:104030000-104060000"

##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_PLINK_REPORTS
