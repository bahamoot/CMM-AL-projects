#!/bin/bash -l
 
#SBATCH -A b2011097
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 2-00:00:00
#SBATCH -J monitor_mutrep_fam242_all_genes

dataset_name="fam242_all_genes"

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-mutation-reports"
cmd+=" -j $CMM_CLIENT/scripts/fam242/$dataset_name"_jobs_setup.txt
cmd+=" -l /proj/b2011117/private/projects/slurm_log/$dataset_name"
eval "$cmd"
