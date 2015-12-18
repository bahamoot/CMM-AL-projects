#!/bin/bash -l
 
#SBATCH -A b2012247
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 2-00:00:00
#SBATCH -J monitor_mutrep_chr10

dataset_name="chr10"
report_regions="10:62100000-69970000"

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-summary-report"
cmd+=" -j $CMM_CLIENT/scripts/hovsep/$dataset_name"_jobs_setup.txt
if [ ! -z $report_regions ]
then
    cmd+=" -r $report_regions"
fi
cmd+=" -l /proj/b2011117/private/projects/slurm_log/$dataset_name"
eval "$cmd"
