#!/bin/bash
 
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-pipeline"
cmd+=" -j $CMM_CLIENT/scripts/xj/xj_jobs_setup.txt"
#cmd+=" -l /proj/b2011117/private/projects/slurm_log/$dataset_name"
eval "$cmd"
