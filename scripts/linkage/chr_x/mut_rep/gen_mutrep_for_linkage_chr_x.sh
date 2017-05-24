#!/bin/bash
 
dataset_name="mutation_linkage_chrX"

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-pipeline"
cmd+=" -j $script_dir/$dataset_name"_jobs_setup.txt
#cmd+=" -l /proj/b2011117/private/projects/slurm_log/$dataset_name"
eval "$cmd"
