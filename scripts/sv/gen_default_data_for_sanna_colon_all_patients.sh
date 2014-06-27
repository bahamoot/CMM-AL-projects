#!/bin/bash

project_name="sanna_colon_rectal"
sub_project_name="colon_all_patients"
dataset_name="sv_colon_all_patients"

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

# vcf region from ~#rs6935293-rs34710081
export DEFAULT_DATA_VCF_REGION="6:38004942-45000000"
#col_names="Co90,Co89,Co135,Co131,Co700,Co454,1526-02D,Co1301,Co616,Co1156,Co837,Co840,Co1053,1104-03D,Co866,Co1031,Co1037,Co1051,Co1534,468-04,354-06"
##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_DEFAULT_DATA
