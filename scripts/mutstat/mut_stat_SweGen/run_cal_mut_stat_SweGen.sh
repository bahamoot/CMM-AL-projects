module load annovar

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-cmmdb-vcf-AF-to-annovar "
cmd+=" -j $script_dir/cal_mut_stat_SweGen_jobs_setup.txt"
#cmd+=" -t 5-00:00:00"
#cmd+=" -l /proj/b2011117/private/projects/out/db/cal_stat_101CRC_all/101CRC_all"
eval "$cmd"
