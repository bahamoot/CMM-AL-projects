#!/bin/bash -l
#SBATCH -A b2012247
#SBATCH -p core -n 1
#SBATCH -t 7-00:00:00
#SBATCH -J xls_chr9_fam24_axeq_p08


script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

project_name="chr9_fam24"
sub_project_name="axeq_p08"
annotation_file=$CMM_AXEQ_CHR9_SA_DB
vcf_gz_file=$CMM_AXEQ_CHR9_ALL_PATIENTS_GZ
#region="9:104021755-104090735"

#$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "24" -m "Co648" -R $region
$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "24" -m "Co166,Co213,Co648"
