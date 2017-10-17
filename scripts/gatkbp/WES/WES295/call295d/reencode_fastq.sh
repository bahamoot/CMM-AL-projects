#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
project_code="b2012247"
total_run_time="12:00:00"
output_dir="/proj/b2011117/private/raw_exome_sequencing_data/CRC_Prostrate/reencode"
slurm_log_dir="/proj/b2011117/nobackup/private/projects_output/gatkbp/WES/WES295/CRC_Prostrate/slurm_log/"
script_file="$PYCMM/bash/change_encoding.sh"

running_time=$(date +"%Y%m%d%H%M%S")

function submit_encode_job {
    fastq_folder=$1

    sample_name=$(basename "$fastq_folder")
    

    sbatch_cmd_prefix="sbatch"
    sbatch_cmd_prefix+=" -A $project_code"
    sbatch_cmd_prefix+=" -p core"
    sbatch_cmd_prefix+=" -n 2"
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
        sbatch_cmd+=" -o $output_dir"
        echo "$sbatch_cmd"
        eval "$sbatch_cmd"
    done
}

CRC_samples_root="/proj/b2011117/private/raw_exome_sequencing_data/CRC_Prostrate"

CRC_samples_subroot1="$CRC_samples_root/110623_SN866_0054_AD030MACXX"
#submit_encode_job "$CRC_samples_subroot1/Sample_134-06"
#submit_encode_job "$CRC_samples_subroot1/Sample_1526-02D"
#submit_encode_job "$CRC_samples_subroot1/Sample_354-06"
#submit_encode_job "$CRC_samples_subroot1/Sample_468-04"
#submit_encode_job "$CRC_samples_subroot1/Sample_474-05"
#submit_encode_job "$CRC_samples_subroot1/Sample_529-05"
submit_encode_job "$CRC_samples_subroot1/Sample_642-06"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1031"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1037"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1051"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1207"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1274"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1301"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1534"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1583"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1584"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1591"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-1595"
submit_encode_job "$CRC_samples_subroot1/Sample_Co-1600"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-846"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-857"
#submit_encode_job "$CRC_samples_subroot1/Sample_Co-866"

CRC_samples_subroot2="$CRC_samples_root/110823_SN344_0114_AC00BGACXX"
#submit_encode_job "$CRC_samples_subroot2/Sample_1052-05"
#submit_encode_job "$CRC_samples_subroot2/Sample_1104-03D"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-1262"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-1458"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-1467"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-1538"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-1552"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-238"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-35"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-37"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-555"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-572"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-618"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-837"
#submit_encode_job "$CRC_samples_subroot2/Sample_Co-840"

#submit_encode_job "$script_dir/resources/CRC_Prostrate/Co-866"
#submit_encode_job "$script_dir/resources/CRC_Prostrate/Co-857"
#submit_encode_job "/proj/b2011158/private/scilife_illumina_exome_sequencing/links/concatted_fastq/Br-724"
#submit_encode_job "/proj/b2011158/private/scilife_illumina_exome_sequencing/links/concatted_fastq/Br-732"
