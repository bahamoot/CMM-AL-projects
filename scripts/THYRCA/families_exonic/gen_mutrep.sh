#!/bin/bash
 
dataset_name="THYRCA"

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-pipeline"
cmd+=" -j $script_dir/$dataset_name"_jobs_setup.txt
cmd+=" -t 2-00:00:00"
#cmd+=" -l /proj/b2011117/private/projects/slurm_log/$dataset_name"
eval "$cmd"
