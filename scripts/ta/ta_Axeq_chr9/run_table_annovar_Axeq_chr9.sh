script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-cmmdb-table-annovar "
cmd+=" -j $script_dir/ta_Axeq_chr9_jobs_setup.txt"
cmd+=" -l /proj/b2011117/private/projects/out/db/ta_Axeq_chr9"
eval "$cmd"