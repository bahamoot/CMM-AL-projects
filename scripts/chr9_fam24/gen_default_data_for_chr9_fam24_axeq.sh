#!/bin/bash

project_name="chr9_fam24"
sub_project_name="family_xls_axeq"
dataset_name="chr9_fam24_axeq"

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
export DEFAULT_DATA_PROJECT_CODE="b2012247"
export DEFAULT_DATA_DATASET_NAME=$dataset_name
export DEFAULT_DATA_TABIX_FILE=$CMM_AXEQ_CHR9_ALL_PATIENTS_GZ
export DEFAULT_DATA_HBVDB_TOOLS_ROOT_DIR=$HBVDB_TOOLS_ROOT_DIR
export DEFAULT_DATA_ANNOVAR_ROOT_DIR=$ANNOVAR_ROOT_DIR
export DEFAULT_DATA_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
export DEFAULT_DATA_LOG_DIR=$CMM_PROJECTS_LOG_DIR

export DEFAULT_DATA_OAF_OUT_FILE=$out_dir/$dataset_name.oaf
export DEFAULT_DATA_GT_VCF_GT_OUT_FILE=$out_dir/$dataset_name.gt.vgt
export DEFAULT_DATA_MT_VCF_GT_OUT_FILE=$out_dir/$dataset_name.mt.vgt
export DEFAULT_DATA_SA_OUT_FILE=$out_dir/$dataset_name.sa

# vcf region from rs1993104 to rs1529958
export DEFAULT_DATA_VCF_REGION="9:98318926-105545483"
export DEFAULT_DATA_COL_NAMES="24-Co213,24-Co166"
##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_DEFAULT_DATA
