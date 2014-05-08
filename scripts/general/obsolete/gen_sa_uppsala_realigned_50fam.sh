#!/bin/bash -l
#SBATCH -A b2011117
#SBATCH -p core -n 1
#SBATCH -t 7-00:00:00
#SBATCH -J gen_sa_uppsala_realigned

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

$SCRIPT_GEN_SA "" "" "" $CMM_UPPSALA_50FAM_ALL_PATIENTS_GZ $CMM_OAF_UPPSALA_REALIGNED_ALL_50FAM "uppsala_realigned_50fam" $CMM_UPPSALA_REALIGNED_50FAM_SA_DB
