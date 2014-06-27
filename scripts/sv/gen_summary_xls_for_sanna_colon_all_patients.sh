#!/bin/bash

project_name="sv"
sub_project_name="colon_all_patients"

if [ ! -d "$CMM_PROJECTS_OUTPUT_DIR/$project_name" ]; then
    mkdir "$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi
if [ ! -z "$sub_project_name" ]; then
    out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
    running_key="$project_name"_"$sub_project_name"
    if [ ! -d "$out_dir" ]; then
        mkdir "$out_dir"
    fi
else
    out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
    running_key="$project_name"
fi

##********************************************* set parameters here *****************************************************
export MUTATIONS_REPORTS_PROJECT_CODE="b2011117"
export MUTATIONS_REPORTS_RUNNING_KEY=$running_key
export MUTATIONS_REPORTS_TABIX_FILE=$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ
export MUTATIONS_REPORTS_ANNOVAR_ROOT_DIR=$ANNOVAR_ROOT_DIR
export MUTATIONS_REPORTS_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
export MUTATIONS_REPORTS_OUT_DIR=$out_dir
export MUTATIONS_REPORTS_LOG_DIR=$CMM_PROJECTS_LOG_DIR

#cache_dir="$out_dir/cache/"
#export MUTATIONS_REPORTS_CACHE_DIR="$cache_dir"

## vcf region from rs10124153 to rs7040414
export MUTATIONS_REPORTS_VCF_REGION="6:38004942-45000000"
#export MUTATIONS_REPORTS_COL_NAMES="185-Co603,185-Co669,312-Co1116,350-1104-03D,350-Co866,650-398-05o,650-729-05o,1290-Co1723"

export MUTATIONS_REPORTS_EXONIC_FILTERING="Off"
export MUTATIONS_REPORTS_MISSENSE_FILTERING="Off"
export MUTATIONS_REPORTS_DELETERIOUS_FILTERING="Off"
#export MUTATIONS_REPORTS_RARE_FILTERING="On"

export MUTATIONS_REPORTS_OAF_RATIO="0.2"
export MUTATIONS_REPORTS_MAF_RATIO="0.2"
##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_MUTATIONS_REPORTS
###********************************************* set parameters here *****************************************************
#export SUMMARY_XLS_RUNNING_KEY=$dataset_name
#export SUMMARY_XLS_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
#export SUMMARY_XLS_OUT_DIR=$in_dir
#
#export SUMMARY_XLS_OAF_IN_FILE=$in_dir/$dataset_name.oaf
##export SUMMARY_XLS_GT_VCF_GT_IN_FILE=$in_dir/$dataset_name.gt.vgt
#export SUMMARY_XLS_MT_VCF_GT_IN_FILE=$in_dir/$dataset_name.mt.vgt
#export SUMMARY_XLS_SA_IN_FILE=$in_dir/$dataset_name.sa
#
### vcf region from rs10124153 to rs7040414
##export SUMMARY_XLS_VCF_REGION="9:104030000-104060000"
#
#export SUMMARY_XLS_EXONIC_FILTERING="Off"
#export SUMMARY_XLS_MISSENSE_FILTERING="Off"
#export SUMMARY_XLS_DELETERIOUS_FILTERING="Off"
##export SUMMARY_XLS_RARE_FILTERING="On"
#
#export SUMMARY_XLS_OAF_RATIO="0.2"
#export SUMMARY_XLS_MAF_RATIO="0.2"
###********************************************* set parameters here *****************************************************
#
#$EXEC_SCRIPT_GEN_SUMMARY_XLS
