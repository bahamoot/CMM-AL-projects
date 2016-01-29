#!/bin/bash -l
 
#SBATCH -A b2011097
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 1-00:00:00
#SBATCH -J monitor_test_gatkbp


project_output_dir=""

cmd="pyCMM-dnaseq-pipeline "
cmd+=" -j $CMM_CLIENT/scripts/RnD/test_gatkbp/test_gatkbp_jobs_setup.txt"
#cmd+=" -l /proj/b2011117/private/gatkbp/axeq_chr9/axeq_chr9"
eval "$cmd"
