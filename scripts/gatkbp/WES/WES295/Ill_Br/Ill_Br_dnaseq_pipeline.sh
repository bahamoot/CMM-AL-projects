#!/bin/bash -l
 
#SBATCH -A b2011097
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 4-00:00:00
#SBATCH -J mntr_DNASeq_Ill_Br


project_output_dir=""

cmd="pyCMM-dnaseq-pipeline "
cmd+=" -j /home/jessada/private/projects/CMM/scripts/gatkbp/Ill_Br/Ill_Br_jobs_setup.txt"
#cmd+=" -l /proj/b2011117/private/gatkbp/Ill_Br/Ill_Br"
eval "$cmd"
