#!/bin/bash

source $PYCMM/bash/cmm_functions.sh
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
job_name="VQSR_294d"
project_code="b2012247"
project_out_dir="$GATK_BESTPRACTICE_OUTPUT_DIR/WES/call294d"
slurm_log_dir="$project_out_dir/slurm_log"
std_out_slurm="$slurm_log_dir/$job_name.%j.out.log"
std_err_slurm="$slurm_log_dir/$job_name.%j.err.log"
tmp_dir="$project_out_dir/tmp"
vcf_dir="$project_out_dir/vcf"

VQSR_script="$PYCMM/bash/GATKBP_VQSR.sh"
input_vcf_gz="$tmp_dir/call294d_genotyped.vcf.gz"
output_vcf_gz="$vcf_dir/WES294d.VQSR.vcf.gz"

submit_job_cmd="sbatch"
submit_job_cmd+=" -A $project_code"
submit_job_cmd+=" -p core"
submit_job_cmd+=" -n 2"
submit_job_cmd+=" -t 4-00:00:00"
submit_job_cmd+=" -J $job_name"
submit_job_cmd+=" -o $std_out_slurm"
submit_job_cmd+=" -e $std_err_slurm"
submit_job_cmd+=" $VQSR_script"
submit_job_cmd+=" -i $input_vcf_gz"
submit_job_cmd+=" -o $output_vcf_gz"

eval_cmd "$submit_job_cmd"

## [DEBUG]  2017-03-20 14:42:37,043 - MainProcess  - pycmm.utils.jobman - executing: 'sbatch -A b2016200 -p core -n 4 -t 4-00:00:00 -J TYRCA_piper_merge_gnt_gvcfs_3_159960001_200000000 -o /proj/b2011117/nobackup/private/projects       _output/gatkbp/WGS/TYRCA/piper/TYRCA_piper_merge/slurm_log/TYRCA_piper_merge_gnt_gvcfs_3_159960001_200000000_20170320144237.log --dependency=afterok:10045807 $PYCMM/bash/GATKBP_genotype_gvcfs.sh  -G /proj/b2011117/nobackup/priva       te/projects_output/gatkbp/WGS/TYRCA/piper/TYRCA_piper_merge/tmp/TYRCA_piper_merge_gnt_gvcfs_3_159960001_200000000_gvcf.list -o /proj/b2011117/nobackup/private/projects_output/gatkbp/WGS/TYRCA/piper/TYRCA_piper_merge/tmp/TYRCA_pi       per_merge_3_159960001_200000000_genotyped.vcf.gz -r /proj/b2011117/private/databases/reference/Homo_sapiens.GRCh37.57.dna.concat.fa'
