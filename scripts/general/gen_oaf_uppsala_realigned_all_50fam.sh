#!/bin/bash -l
#SBATCH -A b2011117
#SBATCH -p core -n 1
#SBATCH -t 7-00:00:00
#SBATCH -J gen_oaf_uppsala

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

$SCRIPT_GEN_OAF $CMM_UPPSALA_50FAM_ALL_PATIENTS_GZ $CMM_HBVDB_UPPSALA_REALIGNED_ALL_50FAM $CMM_OAF_UPPSALA_REALIGNED_ALL_50FAM


