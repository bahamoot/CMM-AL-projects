#!/bin/bash

project_name="vinay_chr19"
#sub_project_name="uppsala"
dataset_name="vinay_chr19"

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

# vcf region from rs1993104 to rs1529958
export DEFAULT_DATA_VCF_REGION="19:52240000-58900000"
export DEFAULT_DATA_COL_NAMES="185-Co603,185-Co669,312-Co1116,350-1104-03D,350-Co866,650-398-05o,650-729-05o,1290-Co1723"
##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_DEFAULT_DATA
