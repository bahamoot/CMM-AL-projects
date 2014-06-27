#!/bin/bash

project_name="RnD"
sub_project_name="test_plink_xls"

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
export PLINK_REPORTS_RUNNING_KEY="$dataset_name"
export PLINK_REPORTS_PLINK_BIN_FILE_PREFIX="$CMM_GENOTYPING_UPPSALA_PROCESSED_PLINK_BIN_FILE_PREFIX"
export PLINK_REPORTS_PLINK_PHENO_FILE="$CMM_GENOTYPING_UPPSALA_COLON_300CTRLS_WO_RELATIVES_PHENO"
export PLINK_REPORTS_FAMILIES_HAPLOTYPES_PLINK_TFILE_PREFIX="$CMM_HAPLOTYPE_CHR9_LKG_PLINK_FILE_PREFIX"
#export PLINK_REPORTS_TFAM_INDIVIDUAL_IDS="fam_8,fam_740,new_fam24_shared_only"
#export PLINK_REPORTS_TFAM_FAMILY_IDS="fam_8,fam_275,fam_478,fam_740,fam_350,fam_918,new_fam24_shared_only"
export PLINK_REPORTS_TFAM_FAMILY_IDS="8,275,478,740,350,918,24"
export PLINK_REPORTS_SPECIAL_FAMILIES_INFO="24:GOLD,740:LIME:MAGENTA"
export PLINK_REPORTS_PLINK_HAP_WINDOW_SIZES="1,3,5,10"
export PLINK_REPORTS_PVALUE_SIGNIFICANCE_RATIO="1"
#export PLINK_REPORTS_PVALUE_SIGNIFICANCE_RATIO="1e-02"
export PLINK_REPORTS_PROJECT_DIR=$project_dir
export PLINK_REPORTS_LOG_DIR=$CMM_PROJECTS_LOG_DIR

cache_dir="$project_dir/cache/9_100000000_105000000"
export PLINK_REPORTS_CACHE_DIR="$cache_dir"
export PLINK_REPORTS_USE_CACHED_PLINK_EXTRA_INFO="On"

#export PLINK_REPORTS_PLINK_REGION="9:104400000-104444000"
#export PLINK_REPORTS_PLINK_REGION="9:103600000-104200000"
export PLINK_REPORTS_PLINK_REGION="9:100000000-105000000"

export PLINK_REPORTS_DEVELOPER_MODE="On"
##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_PLINK_REPORTS
