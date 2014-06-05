#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

project_name="RnD"
sub_project_name="test_plink_xls"

if [ ! -d "$CMM_PROJECTS_OUTPUT_DIR/$project_name" ]; then
    mkdir "$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi
if [ ! -z "$sub_project_name" ]; then
    out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
    dataset_name="$project_name"_"$sub_project_name"
    if [ ! -d "$out_dir" ]; then
        mkdir "$out_dir"
    fi
else
    out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
    dataset_name="$project_name"
fi

#/glob/jessada//lib/CMM-Lib/scripts/plink_dummy.sh --noweb --bfile $CMM_HAPLOTYPE_FAM24_PLINK_BIN_FILE_PREFIX --make-bed --keep <( echo -e "24\tnew_fam24_shared_only" ) --out "$script_dir/haplotype_fam24"
/glob/jessada//lib/CMM-Lib/scripts/plink_dummy.sh --noweb --bfile $CMM_HAPLOTYPE_FAM24_PLINK_BIN_FILE_PREFIX --make-bed --keep <( echo -e "24\tCo-166\n24\tnew_fam24_shared_only\n24\told_fam24_shared_only" ) --out "$script_dir/haplotype_fam24"

##********************************************* set parameters here *****************************************************
export PLINK_REPORTS_RUNNING_KEY="$dataset_name"
export PLINK_REPORTS_PLINK_BIN_FILE_PREFIX="$CMM_GENOTYPING_UPPSALA_PROCESSED_PLINK_BIN_FILE_PREFIX"
export PLINK_REPORTS_PLINK_PHENO_FILE="$CMM_GENOTYPING_UPPSALA_COLON_300CTRLS_WO_RELATIVES_PHENO"
export PLINK_REPORTS_FAMILIES_HAPLOTYPES_PLINK_BIN_FILE_PREFIX="$script_dir/haplotype_fam24"
export PLINK_REPORTS_PLINK_HAP_WINDOW_SIZES="1,3,5,10"
#export PLINK_REPORTS_PLINK_HAP_WINDOW_SIZES="1,3,5,10,20,50,100"
export PLINK_REPORTS_PVALUE_SIGNIFICANCE_RATIO="1e-03"
#export PLINK_REPORTS_PVALUE_SIGNIFICANCE_RATIO="2e-04"
export PLINK_REPORTS_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
export PLINK_REPORTS_OUT_DIR=$out_dir
export PLINK_REPORTS_LOG_DIR=$CMM_PROJECTS_LOG_DIR

cache_dir="$script_dir/cache"
#export PLINK_REPORTS_CACHE_DIR="$cache_dir"
export PLINK_REPORTS_USE_CACHED_PLINK_HAP_ASSOC="On"
export PLINK_REPORTS_USE_CACHED_PLINK_EXTRA_INFO="On"

## vcf region from rs10124153 to rs7040414
#export PLINK_REPORTS_PLINK_REGION="9:98318926-105545483"
#export PLINK_REPORTS_PLINK_REGION="9:92290000-105770000"
export PLINK_REPORTS_PLINK_REGION="9:103600000-104200000"
#export PLINK_REPORTS_PLINK_REGION="9:97136378-105767702"
##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_PLINK_REPORTS
