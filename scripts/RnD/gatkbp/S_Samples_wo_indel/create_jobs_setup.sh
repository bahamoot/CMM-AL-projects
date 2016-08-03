#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="S_Samples_wo_indel"
project_code="b2011097"
reference_file="$REFERENCE_DATA_DIR/Homo_sapiens.GRCh37.57.dna.concat.fa"
project_out_dir="$GATK_BESTPRACTICE_OUTPUT_DIR/RnD/$dataset_name"
samples_root_dir="$script_dir/resources"
#known_indels_file1="$REFERENCE_DATA_DIR/1000G_phase1.indels.b37.vcf"
#known_indels_file2="$REFERENCE_DATA_DIR/Mills_and_1000G_gold_standard.indels.b37.vcf"
dbsnp_file="$REFERENCE_DATA_DIR/dbsnp_138.b37.vcf"
jobs_setup_file="$dataset_name"_jobs_setup.txt
targets_interval_list="$script_dir/targets.interval_list"
indel_recal=True
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
if [ ! -z $known_indels_file1 ]
then
    cmd+=" --known_indels $known_indels_file1 $known_indels_file2"
fi
cmd+=" --dbsnp $dbsnp_file"
if [ ! -z $indel_recal ]
then
    cmd+=" --indel_recal"
fi
if [ ! -z $variants_calling ]
then
    cmd+=" --variants_calling"
fi
if [ ! -z $targets_interval_list ]
then
    cmd+=" --targets_interval_list $targets_interval_list"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
