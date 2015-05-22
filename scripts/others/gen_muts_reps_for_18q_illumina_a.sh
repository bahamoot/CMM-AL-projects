#!/bin/bash

project_name="oth"
sub_project_name="18q_ill_a"

if [ ! -d "$CMM_PROJECTS_OUTPUT_DIR/$project_name" ]; then
    mkdir "$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi
if [ ! -z "$sub_project_name" ]; then
    project_out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
    running_key="$project_name"_"$sub_project_name"
    if [ ! -d "$project_out_dir" ]; then
        mkdir "$project_out_dir"
    fi
else
    project_out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
    running_key="$project_name"
fi


##********************************************* set parameters here *****************************************************
export MUTATIONS_REPORTS_PROJECT_CODE="b2012247"
export MUTATIONS_REPORTS_TOTAL_RUN_TIME="1-00:00:00"
export MUTATIONS_REPORTS_RUNNING_KEY=$running_key
export MUTATIONS_REPORTS_TABIX_FILE=$CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_MANS_GZ
export MUTATIONS_REPORTS_ANNOVAR_ROOT_DIR=$ANNOVAR_ROOT_DIR
export MUTATIONS_REPORTS_PROJECT_OUT_DIR=$project_out_dir
export MUTATIONS_REPORTS_SLURM_LOG_DIR=$CMM_PROJECTS_SLURM_LOG_DIR

#cache_dir="$project_dir/cache"
#export MUTATIONS_REPORTS_CACHE_DIR="$cache_dir"

MUTATIONS_REPORTS_STAT_CONFIG="Illumina-ALL,$CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_MANS_GZ,,PF#6"
MUTATIONS_REPORTS_STAT_CONFIG+=":Axeq-ALL,$CMM_AXEQ_CHR3_6_14_18_ALL_PATIENTS_GZ,,PF"
MUTATIONS_REPORTS_STAT_CONFIG+=":Uppsala-ALL,$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ,,PF"
#MUTATIONS_REPORTS_STAT_CONFIG+=":Uppsala-CAFAM,$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ,$CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_CAFAM,PF-GF"
#MUTATIONS_REPORTS_STAT_CONFIG+=":Uppsala-CRC,$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ,$CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_CRC,PF-GF"
#MUTATIONS_REPORTS_STAT_CONFIG+=":Uppsala-COLON,$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ,$CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_COLON,PF-GF"
#MUTATIONS_REPORTS_STAT_CONFIG+=":Uppsala-RECTAL,$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ,$CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_RECTAL,PF-GF"
MUTATIONS_REPORTS_STAT_CONFIG+=":SWEDES,$SWEDES_STAT,,PF"
export MUTATIONS_REPORTS_STAT_CONFIG

export MUTATIONS_REPORTS_FREQUENCY_RATIOS="1000G:0.2"
export MUTATIONS_REPORTS_MODIFY_HEADER="Illumina-ALL_PF:OAF,Axeq-ALL_PF:Axeq_OAF,Uppsala-ALL_PF:CRC_OAF,SWEDES_PF:Daniel_DB"

export MUTATIONS_REPORTS_DEVELOPER_MODE="On"
## vcf region from rs10124153 to rs7040414
export MUTATIONS_REPORTS_TABIX_VCF_REGION="18:24849600-62010500"
export MUTATIONS_REPORTS_EXTRA_ATTRIBUTES="has_shared,rare,cases_ge_ctrls,has_mutation"
#export MUTATIONS_REPORTS_COL_NAMES="6100-Br-466,2060-Br-693,L862-Br-706"
#export MUTATIONS_REPORTS_FAMILIES_INFO="185:185-Co603:185-Co669,312:312-Co1116,350:350-1104-03D:350-Co866,650:650-398-05o:650-729-05o,1290:1290-Co1723"

##********************************************* set parameters here *****************************************************

if [ ! -z "$MUTATIONS_REPORTS_PROJECT_CODE" ]; then
    export CMM_LIB_DIR="$CMM_LIB_ROOT_DIR/dev_serv/scripts"
else
    export CMM_LIB_DIR="$CMM_LIB_ROOT_DIR/dev_adhoc/scripts"
fi
export CMM_LIB_DIR="$CMM_LIB_ROOT_DIR/dev_serv/scripts"
$CMM_LIB_DIR/exec_script_gen_mutations_reports.sh
