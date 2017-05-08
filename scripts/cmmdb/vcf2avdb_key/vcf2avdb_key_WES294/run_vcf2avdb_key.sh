#!/bin/bash


script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

job_name="vcf2avdb_key_WES294"

cmd="sbatch"
cmd+=" -A b2016331"
cmd+=" -p core"
cmd+=" -n 1"
cmd+=" -N 1"
cmd+=" -J $job_name"
cmd+=" -t 24:00:00"
cmd+=" -o $job_name.%j.out"
cmd+=" -e $job_name.%j.err"
cmd+=" $script_dir/vcf2avdb_key.sh"
#cmd="pyCMM-cmmdb-cal-mut-stat "
#cmd+=" -j $script_dir/cal_mut_stat_OAF_CRCs_jobs_setup.txt"
#cmd+=" -l /proj/b2011117/private/projects/out/db/cal_stat_101CRC_all/101CRC_all"
eval "$cmd"
