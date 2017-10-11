#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

bam2fastq_script="/proj/b2016200/INBOX/P5255/P5255_101/02-FASTQ/bam2fastq.sh"

file1="/proj/b2011117/private/raw_WGS_data/TYRCA/fastq/F0002468/2016-08616/2016-08616.bam"
file2="/proj/b2011117/private/raw_WGS_data/TYRCA/fastq/F0002468/2015-12231/2015-12231.bam"
file3="/proj/b2011117/private/raw_WGS_data/TYRCA/fastq/F0002468/2015-12232/2015-12232.bam"
file4="/proj/b2011117/private/raw_WGS_data/TYRCA/fastq/F0002322/2015-12460/2015-12460.bam"
file5="/proj/b2011117/private/raw_WGS_data/TYRCA/fastq/F0002322/2016-00043/2016-00043.bam"
file6="/proj/b2011117/private/raw_WGS_data/TYRCA/fastq/F0002322/2016-18116/2016-18116.bam"
file7="/proj/b2011117/private/raw_WGS_data/TYRCA/fastq/F0007826/1415-10D/1415-10D.bam"
file8="/proj/b2011117/private/raw_WGS_data/TYRCA/fastq/F0007826/1416-10D/1416-10D.bam"
file9="/proj/b2011117/private/raw_WGS_data/TYRCA/fastq/F0007826/1417-10D/1417-10D.bam"

sbatch -A b2016200 -J bam2fastq1 $bam2fastq_script $file1
sbatch -A b2016200 -J bam2fastq2 $bam2fastq_script $file2
sbatch -A b2016200 -J bam2fastq3 $bam2fastq_script $file3
sbatch -A b2016200 -J bam2fastq4 $bam2fastq_script $file4
sbatch -A b2016200 -J bam2fastq5 $bam2fastq_script $file5
sbatch -A b2016200 -J bam2fastq6 $bam2fastq_script $file6
sbatch -A b2016200 -J bam2fastq7 $bam2fastq_script $file7
sbatch -A b2016200 -J bam2fastq8 $bam2fastq_script $file8
sbatch -A b2016200 -J bam2fastq9 $bam2fastq_script $file9

