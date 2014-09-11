#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

project_name="RnD"
sub_project_name="test_cal_mut_stat"

if [ ! -d "$CMM_PROJECTS_OUTPUT_DIR/$project_name" ]; then
    mkdir "$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi
if [ ! -z "$sub_project_name" ]; then
    project_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
    dataset_name="$project_name"_"$sub_project_name"
    if [ ! -d "$project_dir" ]; then
        mkdir "$project_dir"
    fi
else
    project_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
    dataset_name="$project_name"
fi

project_working_dir="$project_dir/tmp"
if [ ! -d "$project_working_dir" ]; then
    mkdir $project_working_dir
fi
project_data_out_dir="$project_dir/data_out"
if [ ! -d "$project_data_out_dir" ]; then
    mkdir $project_data_out_dir
fi
project_log_dir="$project_dir/log"
if [ ! -d "$project_log_dir" ]; then
    mkdir $project_log_dir
fi

running_key=$dataset_name
running_time=$(date +"%Y%m%d%H%M%S")
running_log_file="$project_log_dir/$running_key"_"$running_time".log
touch $running_log_file

###********************************************* set parameters here *****************************************************
export MUTATIONS_STAT_RUNNING_KEY=$running_key"_CAFAM"
export MUTATIONS_STAT_WORKING_DIR=$project_working_dir
export MUTATIONS_STAT_OUT_DIR=$project_data_out_dir
export MUTATIONS_STAT_LOG_FILE=$running_log_file
export MUTATIONS_STAT_TABIX_FILE=$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ

# vcf region from rs10124153 to rs7040414
#export MUTATIONS_STAT_VCF_REGION="9:104030000-104033000"
#export MUTATIONS_STAT_VCF_REGION="9:104086506-104086507"
#export MUTATIONS_STAT_VCF_REGION="9:104030000-104086507"
export MUTATIONS_STAT_VCF_REGION="9:104030000-104060000"

#export MUTATIONS_STAT_COL_CONFIG="695-Co1354,695-Co1359,695-Co1368"
export MUTATIONS_STAT_COL_CONFIG="/glob/jessada/private/master_data/CMM/family/processed/uppsala/uppsala_pats_all_members.lst.CAFAM"
$EXEC_SCRIPT_CAL_MUTATIONS_STAT

#export MUTATIONS_STAT_RUNNING_KEY=$running_key"_NON_CAFAM"
#export MUTATIONS_STAT_COL_CONFIG="/glob/jessada/private/master_data/CMM/family/processed/uppsala/uppsala_pats_all_members.lst.NON_CAFAM"
#$EXEC_SCRIPT_CAL_MUTATIONS_STAT

###********************************************* set parameters here *****************************************************
#
