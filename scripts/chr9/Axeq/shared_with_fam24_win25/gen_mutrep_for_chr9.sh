#!/bin/bash -l
 
#SBATCH -A b2012247
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 2-00:00:00
#SBATCH -J mnt_mutrep_chr9_axeq_shared

dataset_name="Axeq_shared_with_fam24_win25"

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-mutation-reports"
cmd+=" -j $CMM_CLIENT/scripts/chr9/Axeq/shared_with_fam24_win25/$dataset_name"_jobs_setup.txt
#cmd+=" -l /proj/b2011117/private/projects/slurm_log/$dataset_name"
eval "$cmd"
