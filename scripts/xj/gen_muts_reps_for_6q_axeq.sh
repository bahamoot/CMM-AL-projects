#!/bin/bash -l
 
#SBATCH -A b2011158
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 7-00:00:00
#SBATCH -J monitor_xj_6q_axq

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-mutation-reports"
cmd+=" -j $CMM_CLIENT/scripts/xiang/xj_6q_jobs_setup.txt"
cmd+=" -l /proj/b2011117/private/projects/out/xj/6q_axq/6q_axq"
eval "$cmd"
