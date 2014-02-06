#!/bin/bash -l
#SBATCH -A b2012247
#SBATCH -p core -n 1
#SBATCH -t 7-00:00:00
#SBATCH -J xls_chr9_linkage_p05


script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

project_name="chr9_linkage"
sub_project_name="p05"
annotation_file=$CMM_AXEQ_CHR9_SA_DB
vcf_gz_file=$CMM_AXEQ_CHR9_ALL_PATIENTS_GZ
region="9:98478118-98504905"

$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "161" -m "Co809"  -R $region
$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "275" -m "Co618"  -R $region
$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "869" -m "Co1685"  -R $region
$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "1025" -m "Co1529"  -R $region
$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "1085" -m "Co1518"  -R $region
$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "1252" -m "Co1719"  -R $region
