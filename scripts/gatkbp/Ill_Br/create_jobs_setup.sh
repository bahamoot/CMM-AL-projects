#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="Ill_Br"
sample_group="Ill_Br"
project_code="b2011097"
reference_file="/glob/jessada/private/master_data/reference/Homo_sapiens.GRCh37.57.dna.concat.fa"
project_out_dir="/proj/b2011117/private/gatkbp/Ill_Br/$dataset_name"
samples_root_dir="$script_dir/resources"
known_indels_file1="/glob/jessada/private/master_data/GATK_BestPractice_test_data/known_indels_SNPs/1000G_phase1.indels.b37.vcf"
known_indels_file2="/glob/jessada/private/master_data/GATK_BestPractice_test_data/known_indels_SNPs/Mills_and_1000G_gold_standard.indels.b37.vcf"
dbsnp_file="/glob/jessada/private/master_data/GATK_BestPractice_test_data/known_indels_SNPs/dbsnp_138.b37.vcf"
jobs_setup_file="$dataset_name"_jobs_setup.txt


cmd="pyCMM-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -g $sample_group"
cmd+=" -p $project_code"
cmd+=" -R $reference_file"
cmd+=" -O $project_out_dir"
cmd+=" -I $samples_root_dir"
cmd+=" --known_indels $known_indels_file1 $known_indels_file2"
cmd+=" --dbsnp $dbsnp_file"
cmd+=" --variants_calling"
cmd+=" -o $jobs_setup_file"

eval "$cmd"
