#!/bin/bash -l
#SBATCH -A b2011158
#SBATCH -p core -n 1
#SBATCH -t 7-00:00:00
#SBATCH -J gen_oaf_scilife_illumina

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

$SCRIPT_GEN_OAF $CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_MANS_GZ $CMM_HBVDB_SCILIFE_ILLUMINA_ALL_FAM $CMM_OAF_SCILIFE_ILLUMINA_ALL_FAM
