#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="TYRCA_piper_merge"
project_code="b2016200"
reference_file="$GRCH37_REF"
project_out_dir="$GATK_BESTPRACTICE_OUTPUT_DIR/WGS/TYRCA/piper/$dataset_name"
samples_root_dir="$script_dir/resources"
known_indels_file1="$REFERENCE_DATA_DIR/1000G_phase1.indels.b37.vcf"
known_indels_file2="$REFERENCE_DATA_DIR/Mills_and_1000G_gold_standard.indels.b37.vcf"
dbsnp_file="$REFERENCE_DATA_DIR/dbsnp_138.b37.vcf"
jobs_setup_file="$dataset_name"_jobs_setup.txt
split_regions_file="$script_dir/split.regions_file"
variants_calling=True


cmd="pyCMM-dnaseq-create-job-setup-file"
cmd+=" -d $dataset_name"
if [ ! -z $project_code ] 
then
    cmd+=" -p $project_code"
fi
cmd+=" -R $reference_file"
cmd+=" -O $project_out_dir"
cmd+=" -I $samples_root_dir"
cmd+=" --known_indels $known_indels_file1 $known_indels_file2"
cmd+=" --dbsnp $dbsnp_file"
#if [ ! -z $indel_recal ]
#then
#    cmd+=" --indel_recal"
#fi
if [ ! -z $variants_calling ]
then
    cmd+=" --variants_calling"
fi
if [ ! -z $preprocess_sample ]
then
    cmd+=" --preprocess_sample"
fi
if [ ! -z $targets_interval_list ]
then
    cmd+=" --targets_interval_list $targets_interval_list"
fi
if [ ! -z $split_regions_file ]
then
    cmd+=" --split_regions_file $split_regions_file"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
