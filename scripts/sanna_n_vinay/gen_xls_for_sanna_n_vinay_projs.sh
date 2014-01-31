#!/bin/bash -l
#SBATCH -A b2012247
#SBATCH -p core -n 1
#SBATCH -t 7-00:00:00
#SBATCH -J xls_chr9_linkage_p05

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ~/.bashrc

project_name="sanna_n_vinay"
annotation_file=$CMM_UPPSALA_REALIGNED_50FAM_SA_DB
vcf_gz_file=$CMM_UPPSALA_50FAM_ALL_PATIENTS_GZ

#---------- recessive model colon cancer --------------
sub_project_name="colon_recessive_chr6"
region="6:37763732-45479949"
##rs1738240 = 38763732
##rs941983  = 44479949

$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "110" -m "1526-02D,Co1301" -R $region
$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "301" -m "Co837,Co840,Co1053" -R $region
$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "650" -m "398-05o,729-05o" -R $region


#---------- recessive model rectal cancer --------------
sub_project_name="rectal_recessive_chr18"
region="18:9928706-21607819"
##rs906283  = 10928706
##rs1010800 = 20607819

$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "8" -m "Co35,Co37" -R $region
$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "918" -m "134-06,354-06" -R $region
$SCRIPT_GEN_XLS -p $project_name -s $sub_project_name -a $annotation_file -v $vcf_gz_file -f "1213" -m "Co1666" -R $region
