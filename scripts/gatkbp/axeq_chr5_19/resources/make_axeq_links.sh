#!/bin/bash

fastq_dir=$1

for fastq_file in $fastq_dir/*.fastq.gz
do
    file_name=$(basename "$fastq_file")
    echo $file_name
#    ln -s $fastq_file $file_name
done

#script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#
#project_output_dir="$CMM_PROJECTS_OUTPUT_DIR"
#project_name="RnD"
#sub_project_name="dnaseq_pipeline"
#
#if [ ! -d "$project_output_dir/$project_name" ]; then
#    mkdir "$project_output_dir/$project_name"
#fi
#if [ ! -z "$sub_project_name" ]; then
#    sub_project_output_dir="$project_output_dir/$project_name/$sub_project_name"
#    running_key="$project_name"_"$sub_project_name"
#else
#    sub_project_output_dir="$project_output_dir/$project_name"
#    running_key="$project_name"
#fi
#
#source "$script_dir/../../client_utils.sh"
#create_directory_structure "$sub_project_output_dir"
#
#pyCMM-dnaseq-pipeline -j ia --debug -l "$sub_project_output_dir/log/$running_key"
