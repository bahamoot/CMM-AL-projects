#!/bin/bash

#script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
project_code="b2011158"
total_run_time="4-00:00:00"
working_dir="/proj/b2011117/private/gatkbp/Ill_Br/tmp"
slurm_log_dir="/proj/b2011117/private/gatkbp/Ill_Br/slurm_log"
script_file="$PYCMM/bash/change_encoding.sh"

running_time=$(date +"%Y%m%d%H%M%S")

function submit_encode_job {
    fastq_folder=$1

    sample_name=$(basename "$fastq_folder")
    

    sbatch_cmd_prefix="sbatch"
    sbatch_cmd_prefix+=" -A $project_code"
    sbatch_cmd_prefix+=" -p core"
    sbatch_cmd_prefix+=" -n 1"
    sbatch_cmd_prefix+=" -t $total_run_time"

    job_count=0
    for fastq_gz in $fastq_folder/*.fastq.gz
    do
        job_count=$((job_count + 1))
        job_name="$sample_name"_reencode_"$job_count"
        slurm_log_file="$slurm_log_dir/$job_name"_"$running_time".log
        sbatch_cmd=$sbatch_cmd_prefix
        sbatch_cmd+=" -J $job_name"
        sbatch_cmd+=" -o $slurm_log_file"
        sbatch_cmd+=" $script_file"
        sbatch_cmd+=" -I $fastq_gz"
        sbatch_cmd+=" -w $working_dir"
        echo "$sbatch_cmd"
        eval "$sbatch_cmd"
    done
}

#submit_encode_job "/proj/b2011158/private/scilife_illumina_exome_sequencing/links/concatted_fastq/Br-652"
#submit_encode_job "/proj/b2011158/private/scilife_illumina_exome_sequencing/links/concatted_fastq/Br-724"
#submit_encode_job "/proj/b2011158/private/scilife_illumina_exome_sequencing/links/concatted_fastq/Br-732"
