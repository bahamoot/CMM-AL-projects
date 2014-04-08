#!/bin/bash

project_name="chr9_linkage"
sub_project_name="uppsala"
dataset_name="chr9_linkage_uppsala"

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


##********************************************* set parameters here *****************************************************
export DEFAULT_DATA_PROJECT_CODE="b2011117"
export DEFAULT_DATA_DATASET_NAME=$dataset_name
export DEFAULT_DATA_TABIX_FILE=$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ
export DEFAULT_DATA_HBVDB_TOOLS_ROOT_DIR=$HBVDB_TOOLS_ROOT_DIR
export DEFAULT_DATA_ANNOVAR_ROOT_DIR=$ANNOVAR_ROOT_DIR
export DEFAULT_DATA_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
export DEFAULT_DATA_LOG_DIR=$CMM_PROJECTS_LOG_DIR

export DEFAULT_DATA_OAF_OUT_FILE=$out_dir/$dataset_name.oaf
export DEFAULT_DATA_GT_VCF_GT_OUT_FILE=$out_dir/$dataset_name.gt.vgt
export DEFAULT_DATA_MT_VCF_GT_OUT_FILE=$out_dir/$dataset_name.mt.vgt
export DEFAULT_DATA_SA_OUT_FILE=$out_dir/$dataset_name.sa

#export DEFAULT_DATA_PROJECT_NAME="chr9_linkage"
#export DEFAULT_DATA_SUB_PROJECT_NAME="uppsala"

export DEFAULT_DATA_VCF_REGION="9:92298000-105323000"
export DEFAULT_DATA_COL_NAMES="8-Co35,8-Co37,275-Co1262,275-Co618,478-Co1274,478-Co1207,740-1373,740-602-05o,740-1383,13-Co95,296-Co793,296-Co876,350-866,350-1104-03D,918-134-06,918-354-06,358-1104-03D,358-Co866,12-89,12-90,91-454,91-700,231-Co555,231-Co572,425-Co1458,425-Co1595"
##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_DEFAULT_DATA
