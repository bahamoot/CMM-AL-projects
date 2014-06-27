#!/bin/bash

project_name="vinay_chr19"
#sub_project_name="mut_reps"

if [ ! -d "$CMM_PROJECTS_OUTPUT_DIR/$project_name" ]; then
    mkdir "$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi
if [ ! -z "$sub_project_name" ]; then
    project_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
    running_key="$project_name"_"$sub_project_name"
    if [ ! -d "$project_dir" ]; then
        mkdir "$project_dir"
    fi
else
    project_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
    running_key="$project_name"
fi


##********************************************* set parameters here *****************************************************
export MUTATIONS_REPORTS_PROJECT_CODE="b2011117"
export MUTATIONS_REPORTS_RUNNING_KEY=$running_key
export MUTATIONS_REPORTS_TABIX_FILE=$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ
export MUTATIONS_REPORTS_ANNOVAR_ROOT_DIR=$ANNOVAR_ROOT_DIR
export MUTATIONS_REPORTS_PROJECT_DIR=$project_dir
export MUTATIONS_REPORTS_LOG_DIR=$CMM_PROJECTS_LOG_DIR

#cache_dir="$project_dir/cache"
#export MUTATIONS_REPORTS_CACHE_DIR="$cache_dir"

## vcf region from rs10124153 to rs7040414
export MUTATIONS_REPORTS_VCF_REGION="19:52240000-58900000"
#export MUTATIONS_REPORTS_COL_NAMES="185-Co603,185-Co669,312-Co1116,350-1104-03D,350-Co866,650-398-05o,650-729-05o,1290-Co1723"
export MUTATIONS_REPORTS_FAMILIES_INFO="185:185-Co603:185-Co669,312:312-Co1116,350:350-1104-03D:350-Co866,650:650-398-05o:650-729-05o,1290:1290-Co1723"

export MUTATIONS_REPORTS_EXONIC_FILTERING="Off"
export MUTATIONS_REPORTS_MISSENSE_FILTERING="Off"
export MUTATIONS_REPORTS_DELETERIOUS_FILTERING="Off"
#export MUTATIONS_REPORTS_RARE_FILTERING="On"

export MUTATIONS_REPORTS_OAF_RATIO="0.2"
export MUTATIONS_REPORTS_MAF_RATIO="0.2"
##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_MUTATIONS_REPORTS