#!/bin/bash -l
 
#SBATCH -A b2012247
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 40:00:00
#SBATCH -J mnt_mutrep_fam24_gw

dataset_name="fam24_gw"

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-mutation-reports"
#cmd="pyCMM-mutrep-summary-report"
#cmd="pyCMM-mutrep-family-report"
#cmd+=" -f 24"
#cmd+=" -r 18"
#cmd+=" -r 1:16360136-16456764"
#cmd+=" -o /proj/b2011117/private/projects/out/chr9/$dataset_name/rpts/$dataset_name"_fam_custom.xlsx
cmd+=" -j $CMM_CLIENT/scripts/chr9/fam24_gw/$dataset_name"_jobs_setup.txt
#cmd+=" -l /proj/b2011117/private/projects/slurm_log/$dataset_name"
eval "$cmd"
