#!/bin/bash -l
 
#SBATCH -A b2011097
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 3-00:00:00
#SBATCH -J mntr_mutrep_Ill_Br_fam242

dataset_name="Illumina"

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-mutation-reports"
cmd+=" -j $CMM_CLIENT/scripts/standard/mutrep_Ill_Br_fam242/$dataset_name"_jobs_setup.txt
#cmd+=" -l /proj/b2011117/private/projects/slurm_log/$dataset_name"
eval "$cmd"
