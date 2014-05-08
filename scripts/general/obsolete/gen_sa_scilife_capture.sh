#!/bin/bash -l
#SBATCH -A b2012247
#SBATCH -p core -n 1
#SBATCH -t 7-00:00:00
#SBATCH -J gen_sa_scilife_capture

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

$SCRIPT_GEN_SA "" "" "" $CMM_SCILIFE_CAPTURE_FAM24_PATIENTS_GZ $CMM_OAF_AXEQ_CHR9_ALL_FAM "scilife_capture" $CMM_SCILIFE_CAPTURE_FAM24_SA_DB
