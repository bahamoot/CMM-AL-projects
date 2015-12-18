#!/bin/bash -l
 
#SBATCH -A b2011097
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 4-00:00:00
#SBATCH -J monitor_axeq_chr9


project_output_dir=""

cmd="pyCMM-dnaseq-pipeline "
cmd+=" -j /home/jessada/private/projects/CMM/scripts/gatkbp/axeq_chr9/axeq_chr9_jobs_setup.txt"
cmd+=" -l /proj/b2011117/private/gatkbp/axeq_chr9/axeq_chr9"
eval "$cmd"
