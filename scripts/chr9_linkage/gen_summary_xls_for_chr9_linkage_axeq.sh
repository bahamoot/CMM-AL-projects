#!/bin/bash

project_name="chr9_lkg"
sub_project_name="axeq"
dataset_name="chr9_lkg_axeq"

if [ ! -z "$sub_project_name" ]; then
    in_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
else
    in_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi


##********************************************* set parameters here *****************************************************
export SUMMARY_XLS_PROJECT_CODE="b2012247"
export SUMMARY_XLS_RUNNING_KEY=$dataset_name
export SUMMARY_XLS_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
export SUMMARY_XLS_OUT_DIR=$in_dir
export SUMMARY_XLS_LOG_DIR=$CMM_PROJECTS_LOG_DIR

export SUMMARY_XLS_OAF_IN_FILE=$in_dir/$dataset_name.oaf
#export SUMMARY_XLS_GT_VCF_GT_IN_FILE=$in_dir/$dataset_name.gt.vgt
export SUMMARY_XLS_MT_VCF_GT_IN_FILE=$in_dir/$dataset_name.mt.vgt
export SUMMARY_XLS_SA_IN_FILE=$in_dir/$dataset_name.sa

# vcf region from rs10124153 to rs7040414
export SUMMARY_XLS_VCF_REGION="9:104030000-104060000"

export SUMMARY_XLS_EXONIC_FILTERING="Off"
export SUMMARY_XLS_MISSENSE_FILTERING="Off"
export SUMMARY_XLS_DELETERIOUS_FILTERING="Off"
#export SUMMARY_XLS_RARE_FILTERING="Off"

export SUMMARY_XLS_OAF_RATIO="0.2"
export SUMMARY_XLS_MAF_RATIO="0.2"
##********************************************* set parameters here *****************************************************


$EXEC_SCRIPT_GEN_SUMMARY_XLS
