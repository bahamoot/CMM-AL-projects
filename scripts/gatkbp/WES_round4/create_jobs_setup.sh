#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="WES_round4"
project_code="b2012247"
reference_file="$REFERENCE_DATA_DIR/Homo_sapiens.GRCh37.57.dna.concat.fa"
project_out_dir="$GATK_BESTPRACTICE_OUTPUT_DIR/WES/$dataset_name"
samples_root_dir="$script_dir/resources"
known_indels_file1="$REFERENCE_DATA_DIR/1000G_phase1.indels.b37.vcf"
known_indels_file2="$REFERENCE_DATA_DIR/Mills_and_1000G_gold_standard.indels.b37.vcf"
dbsnp_file="$REFERENCE_DATA_DIR/dbsnp_138.b37.vcf"
jobs_setup_file="$dataset_name"_jobs_setup.txt


cmd="pyCMM-dnaseq-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -p $project_code"
cmd+=" -R $reference_file"
cmd+=" -O $project_out_dir"
cmd+=" -I $samples_root_dir"
cmd+=" --known_indels $known_indels_file1 $known_indels_file2"
cmd+=" --dbsnp $dbsnp_file"
#cmd+=" --variants_calling"
cmd+=" -o $jobs_setup_file"

eval "$cmd"
