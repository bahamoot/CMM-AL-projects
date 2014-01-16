#!/bin/bash -l
#SBATCH -A b201247
#SBATCH -p core -n 1
#SBATCH -t 7-00:00:00
#SBATCH -J gen_oaf_axeq

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

$SCRIPT_GEN_OAF $CMM_AXEQ_CHR9_ALL_PATIENTS_GZ $CMM_HBVDB_AXEQ_CHR9_ALL_FAM $CMM_OAF_AXEQ_CHR9_ALL_FAM

