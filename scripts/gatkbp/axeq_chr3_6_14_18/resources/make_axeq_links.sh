#!/bin/bash

fastq_dir=$1

for fastq_file in $fastq_dir/*.fastq.gz
do
    file_name=$(basename "$fastq_file")
    echo $file_name
    ln -s $fastq_file $file_name
done

