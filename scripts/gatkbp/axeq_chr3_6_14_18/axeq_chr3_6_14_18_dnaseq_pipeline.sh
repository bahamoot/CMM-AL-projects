#!/bin/bash -l
 
#SBATCH -A b2011097
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 168:00:00
#SBATCH -J monitor_axeq_chr3_6_14_18


project_output_dir=""

cmd="pyCMM-dnaseq-pipeline "
cmd+=" -j /home/jessada/private/projects/CMM/scripts/gatkbp/axeq_chr3_6_14_18/axeq_chr3_6_14_18_jobs_setup.txt"
cmd+=" -l /proj/b2011117/nobackup/private/gatkbp/axeq_chr3_6_14_18/axeq_chr3_6_14_18"
eval "$cmd"
