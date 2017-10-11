#!/bin/bash

source $PYCMM/bash/cmm_functions.sh
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
job_name="la_avdb_294d"
project_code="b2012247"
project_out_dir="$GATK_BESTPRACTICE_OUTPUT_DIR/WES/call294d"
slurm_log_dir="$project_out_dir/slurm_log"
std_out_slurm="$slurm_log_dir/$job_name.%j.out.log"
std_err_slurm="$slurm_log_dir/$job_name.%j.err.log"
vcf_dir="$project_out_dir/vcf"

leftalign_n_avdb_script="$PYCMM/bash/cmmdb_leftalign_n_avdb.sh"
#input_vcf_gz="/home/jessada/private/projects/CMM/scripts/gatkbp/WES/WES294/call294d/tmp_vcf/input.vcf.gz"
input_vcf_gz="$vcf_dir/WES294d.VQSR.vcf.gz"
output_vcf="$vcf_dir/WES294d.la.avdb.VQSR_PASSED.empty.vcf"

submit_job_cmd="sbatch"
submit_job_cmd+=" -A $project_code"
submit_job_cmd+=" -p core"
submit_job_cmd+=" -n 2"
submit_job_cmd+=" -t 4-00:00:00"
submit_job_cmd+=" -J $job_name"
submit_job_cmd+=" -o $std_out_slurm"
submit_job_cmd+=" -e $std_err_slurm"
submit_job_cmd+=" $leftalign_n_avdb_script"
#submit_job_cmd=" $leftalign_n_avdb_script"
submit_job_cmd+=" -i $input_vcf_gz"
submit_job_cmd+=" -o $output_vcf"

eval_cmd "$submit_job_cmd"
