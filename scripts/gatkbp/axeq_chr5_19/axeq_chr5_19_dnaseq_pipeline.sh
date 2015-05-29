#!/bin/bash -l
 
#SBATCH -A b2011097
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 168:00:00
#SBATCH -J monitor_axeq_chr5_19


project_output_dir=""

cmd="pyCMM-dnaseq-pipeline "
cmd+=" -j /home/jessada/private/projects/CMM/scripts/gatkbp/axeq_chr5_19/axeq_chr5_19_jobs_setup.txt"
cmd+=" -l /proj/b2011117/nobackup/private/gatkbp/axeq_chr5_19/axeq_chr5_19"
eval "$cmd"
