#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

project_name="chr9_fam24"
sub_project_name="plink"

if [ ! -d "$CMM_PROJECTS_OUTPUT_DIR/$project_name" ]; then
    mkdir "$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi
if [ ! -z "$sub_project_name" ]; then
    project_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
    dataset_name="$project_name"_"$sub_project_name"
    if [ ! -d "$project_dir" ]; then
        mkdir "$project_dir"
    fi
else
    project_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
    dataset_name="$project_name"
fi


##********************************************* set parameters here *****************************************************
export PLINK_REPORTS_PROJECT_CODE="b2011097"
export PLINK_REPORTS_TOTAL_RUN_TIME="7-00:00:00"
export PLINK_REPORTS_RUNNING_KEY="$dataset_name"
export PLINK_REPORTS_PLINK_BIN_FILE_PREFIX="$CMM_GENOTYPING_UPPSALA_PROCESSED_PLINK_BIN_FILE_PREFIX"
export PLINK_REPORTS_PLINK_PHENO_FILE="$CMM_GENOTYPING_UPPSALA_COLON_300CTRLS_WO_RELATIVES_PHENO"
export PLINK_REPORTS_FAMILIES_HAPLOTYPES_PLINK_TFILE_PREFIX="$CMM_HAPLOTYPE_CHR9_LKG_PLINK_FILE_PREFIX"
export PLINK_REPORTS_TFAM_FAMILY_IDS="8,275,478,740,350,918,24"
#export PLINK_REPORTS_TFAM_INDIVIDUAL_IDS="fam_8,fam_275,fam_478,fam_740,fam_350,fam_918,new_fam24_shared_only"
#export PLINK_REPORTS_PLINK_HAP_WINDOW_SIZES="1,5,10,20,50"
export PLINK_REPORTS_SPECIAL_FAMILIES_INFO="24:GOLD"
export PLINK_REPORTS_PLINK_HAP_WINDOW_SIZES="1,3,5,10,20,50,100"
export PLINK_REPORTS_PVALUE_SIGNIFICANCE_RATIO="2e-04"
export PLINK_REPORTS_WORKING_DIR="$CMM_PROJECTS_WORKING_DIR"
export PLINK_REPORTS_PROJECT_DIR=$project_dir
export PLINK_REPORTS_LOG_DIR="$CMM_PROJECTS_LOG_DIR"

#cache_dir="$project_dir/cache/9_98318926_105545483_old"
#export PLINK_REPORTS_CACHE_DIR="$cache_dir"
export PLINK_REPORTS_USE_CACHED_PLINK_EXTRA_INFO="Off"

export PLINK_REPORTS_PLINK_REGION="9:98318926-105545483"
# PLINK region from chr9 linkage study is from rs4077800 to rs2000182
# rs4077800 = 9:92298167
# rs2000182 = 9:104792809
# PLINK region from chr9 fam24 study is from 9:97136378-105767702
# so combine two study
#export PLINK_REPORTS_PLINK_REGION="9:92290000-105770000"
#export PLINK_REPORTS_PLINK_REGION="9:104030000-104060000"

##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_PLINK_REPORTS
