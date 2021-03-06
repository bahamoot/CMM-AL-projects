#!/bin/bash

project_name="fam242"
sub_project_name="NOTCH1"

if [ ! -d "$CMM_PROJECTS_OUTPUT_DIR/$project_name" ]; then
    mkdir "$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi
if [ ! -z "$sub_project_name" ]; then
    project_out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
    dataset_name="$project_name"_"$sub_project_name"
    if [ ! -d "$project_out_dir" ]; then
        mkdir "$project_out_dir"
    fi
else
    project_out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
    dataset_name="$project_name"
fi


##********************************************* set parameters here *****************************************************
#export PLINK_REPORTS_PROJECT_CODE="b2011097"
export PLINK_REPORTS_RUNNING_KEY="$dataset_name"
export PLINK_REPORTS_PLINK_BIN_FILE_PREFIX="$CMM_GENOTYPING_UPPSALA_PROCESSED_PLINK_BIN_FILE_PREFIX"
export PLINK_REPORTS_PLINK_PHENO_FILE="$CMM_GENOTYPING_UPPSALA_COLON_301CTRLS_WO_RELATIVES_PHENO"
export PLINK_REPORTS_FAMILIES_HAPLOTYPES_PLINK_TFILE_PREFIX="$CMM_HAPLOTYPE_CHR9_LKG_PLINK_FILE_PREFIX"
#export PLINK_REPORTS_TFAM_INDIVIDUAL_IDS="fam_8,fam_740,new_fam24_shared_only"
#export PLINK_REPORTS_TFAM_FAMILY_IDS="fam_8,fam_275,fam_478,fam_740,fam_350,fam_918,new_fam24_shared_only"
export PLINK_REPORTS_UPPSALA_ICF_PCF="$CMM_GENOTYPING_UPPSALA_ICF_TOP_STAT,$CMM_GENOTYPING_UPPSALA_PCF_TOP_STAT"
export PLINK_REPORTS_TFAM_FAMILY_IDS="740,24"
export PLINK_REPORTS_SPECIAL_FAMILIES_INFO="24:GOLD,740:LIME:MAGENTA"
export PLINK_REPORTS_PLINK_HAP_WINDOW_SIZES="1,3,5,7,8,10"
#export PLINK_REPORTS_PVALUE_SIGNIFICANCE_RATIO="1"
export PLINK_REPORTS_PVALUE_SIGNIFICANCE_RATIO="1e-01"
export PLINK_REPORTS_PROJECT_OUT_DIR=$project_out_dir
export PLINK_REPORTS_SLURM_LOG_DIR=$CMM_PROJECTS_SLURM_LOG_DIR

#cache_dir="$project_out_dir/cache/"
#export PLINK_REPORTS_CACHE_DIR="$cache_dir"
#export PLINK_REPORTS_USE_CACHED_PLINK_EXTRA_INFO="On"

export PLINK_REPORTS_PLINK_REGION="9:139387896-139441314"

PLINK_REPORTS_COLOR_REGION="24:DARK_SLATE_GRAY:9:98410000-98460000"
PLINK_REPORTS_COLOR_REGION+=",24:PLUM:9:103969400-104125000"
PLINK_REPORTS_COLOR_REGION+=",24:PLUM:9:104439369-104439370"
PLINK_REPORTS_COLOR_REGION+=",24:PLUM:9:100468000-100525000"
export PLINK_REPORTS_COLOR_REGION

PLINK_REPORTS_COLOR_REGION="24:DARK_SLATE_GRAY:9:98410000-98460000"
PLINK_REPORTS_COLOR_REGION+=",24:PLUM:9:103969400-104125000"
PLINK_REPORTS_COLOR_REGION+=",24:PLUM:9:104439369-104439370"
PLINK_REPORTS_COLOR_REGION+=",24:PLUM:9:100468000-100525000"
export PLINK_REPORTS_COLOR_REGION

export PLINK_REPORTS_DEVELOPER_MODE="On"
##********************************************* set parameters here *****************************************************

if [ ! -z "$PLINK_REPORTS_PROJECT_CODE" ]; then
    export CMM_LIB_DIR="$CMM_LIB_ROOT_DIR/dev_serv/scripts"
else
    export CMM_LIB_DIR="$CMM_LIB_ROOT_DIR/dev_adhoc/scripts"
fi
$CMM_LIB_DIR/exec_script_gen_plink_reports.sh
