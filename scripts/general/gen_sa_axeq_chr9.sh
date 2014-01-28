#!/bin/bash -l
#SBATCH -A b2012247
#SBATCH -p core -n 1
#SBATCH -t 7-00:00:00
#SBATCH -J gen_sa_axeq_chr9

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

$SCRIPT_GEN_SA "" "" "" $CMM_AXEQ_CHR9_ALL_PATIENTS_GZ $CMM_OAF_AXEQ_CHR9_ALL_FAM "axeq_chr9" $CMM_AXEQ_CHR9_SA_DB
