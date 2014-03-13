#!/bin/bash

project_name="vinay_chr19"
#sub_project_name="uppsala"
dataset_name="vinay_chr19"

if [ ! -z "$sub_project_name" ]; then
    in_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
else
    in_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi


##********************************************* set general parameters here *****************************************************
export FAMILY_XLS_RUNNING_KEY=$dataset_name
export FAMILY_XLS_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
export FAMILY_XLS_OUT_DIR=$in_dir

export FAMILY_XLS_OAF_IN_FILE=$in_dir/$dataset_name.oaf
#export FAMILY_XLS_GT_VCF_GT_IN_FILE=$in_dir/$dataset_name.gt.vgt
export FAMILY_XLS_MT_VCF_GT_IN_FILE=$in_dir/$dataset_name.mt.vgt
export FAMILY_XLS_SA_IN_FILE=$in_dir/$dataset_name.sa

## vcf region from rs10124153 to rs7040414
#export FAMILY_XLS_VCF_REGION="9:104030000-104060000"

export FAMILY_XLS_OAF_RATIO="0.2"
export FAMILY_XLS_MAF_RATIO="0.2"
##********************************************* set general parameters here *****************************************************

##********************************************* set parameters and exec each report here *****************************************************

#export DEFAULT_DATA_COL_NAMES=",,,,,"
export FAMILY_XLS_FAMILY_CODE="185"
export FAMILY_XLS_MEMBER_LIST="185-Co603,185-Co669"
$EXEC_SCRIPT_GEN_FAMILY_XLS

export FAMILY_XLS_FAMILY_CODE="312"
export FAMILY_XLS_MEMBER_LIST="312-Co1116"
$EXEC_SCRIPT_GEN_FAMILY_XLS

export FAMILY_XLS_FAMILY_CODE="350"
export FAMILY_XLS_MEMBER_LIST="350-1104-03D,350-Co866"
$EXEC_SCRIPT_GEN_FAMILY_XLS

export FAMILY_XLS_FAMILY_CODE="650"
export FAMILY_XLS_MEMBER_LIST="650-398-05o,650-729-05o"
$EXEC_SCRIPT_GEN_FAMILY_XLS

export FAMILY_XLS_FAMILY_CODE="1290"
export FAMILY_XLS_MEMBER_LIST="1290-Co1723"
$EXEC_SCRIPT_GEN_FAMILY_XLS
