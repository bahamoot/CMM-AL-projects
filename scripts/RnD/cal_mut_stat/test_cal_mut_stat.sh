#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

project_name="RnD"
sub_project_name="test_cal_mut_stat"

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

###********************************************* set parameters here *****************************************************
export MUTATIONS_STAT_RUNNING_KEY=$dataset_name
export MUTATIONS_STAT_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
export MUTATIONS_STAT_OUT_DIR=$out_dir
export MUTATIONS_STAT_TABIX_FILE=$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ

# vcf region from rs10124153 to rs7040414
export MUTATIONS_STAT_VCF_REGION="9:104030000-104033000"
#export MUTATIONS_STAT_VCF_REGION="9:104030000-104086507"
#export MUTATIONS_STAT_VCF_REGION="9:104030000-104060000"

#export MUTATIONS_STAT_COL_NAMES="695-Co1354,695-Co1359,695-Co1368"
#export MUTATIONS_STAT_CAL_ALLELIC_FREQUENCY="Off"
#export MUTATIONS_STAT_CAL_GENOTYPED_FREQUENCY="On"
#export MUTATIONS_STAT_OUT_FILE="$out_dir/$dataset_name.gt_count"
#export DEFAULT_DATA_PROJECT_CODE="b2011117"
#export DEFAULT_DATA_DATASET_NAME=$dataset_name
#export DEFAULT_DATA_HBVDB_TOOLS_ROOT_DIR=$HBVDB_TOOLS_ROOT_DIR
#export DEFAULT_DATA_ANNOVAR_ROOT_DIR=$ANNOVAR_ROOT_DIR
#export DEFAULT_DATA_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
#export DEFAULT_DATA_LOG_DIR=$CMM_PROJECTS_LOG_DIR
#
#export DEFAULT_DATA_OAF_OUT_FILE=$out_dir/$dataset_name.oaf
#export DEFAULT_DATA_GT_VCF_GT_OUT_FILE=$out_dir/$dataset_name.gt.vgt
#export DEFAULT_DATA_MT_VCF_GT_OUT_FILE=$out_dir/$dataset_name.mt.vgt
#export DEFAULT_DATA_SA_OUT_FILE=$out_dir/$dataset_name.sa
#
##export DEFAULT_DATA_PROJECT_NAME="chr9_linkage"
##export DEFAULT_DATA_SUB_PROJECT_NAME="uppsala"
#
##export DEFAULT_DATA_VCF_REGION="9:92298000-105323000"
###********************************************* set parameters here *****************************************************
#
$EXEC_SCRIPT_CAL_MUTATIONS_STAT
