#!/bin/bash

project_name="vinay_chr19"
#sub_project_name="uppsala"
dataset_name="vinay_chr19"

if [ ! -z "$sub_project_name" ]; then
    in_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
else
    in_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi


##********************************************* set parameters here *****************************************************
export CONSENSUS_XLS_RUNNING_KEY=$dataset_name
export CONSENSUS_XLS_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
export CONSENSUS_XLS_OUT_DIR=$in_dir

export CONSENSUS_XLS_OAF_IN_FILE=$in_dir/$dataset_name.oaf
#export CONSENSUS_XLS_GT_VCF_GT_IN_FILE=$in_dir/$dataset_name.gt.vgt
export CONSENSUS_XLS_MT_VCF_GT_IN_FILE=$in_dir/$dataset_name.mt.vgt
export CONSENSUS_XLS_SA_IN_FILE=$in_dir/$dataset_name.sa

## vcf region from rs10124153 to rs7040414
#export CONSENSUS_XLS_VCF_REGION="9:104030000-104060000"

export CONSENSUS_XLS_OAF_RATIO="0.2"
export CONSENSUS_XLS_MAF_RATIO="0.2"
##********************************************* set parameters here *****************************************************


$EXEC_SCRIPT_GEN_CONSENSUS_XLS
