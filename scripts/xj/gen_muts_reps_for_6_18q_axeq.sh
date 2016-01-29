#!/bin/bash -l
 
#SBATCH -A b2011097
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 1-00:00:00
#SBATCH -J mntr_xj_6_18q_axq

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-mutation-reports"
cmd+=" -j $CMM_CLIENT/scripts/xj/xj_jobs_setup.txt"
#cmd+=" -l /proj/b2011117/private/projects/out/xj/18q_axq/18q_axq"
eval "$cmd"
