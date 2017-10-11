
dataset_name="call294d"

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-dnaseq-pipeline "
cmd+=" -t 10-00:00:00"
cmd+=" -j $script_dir/$dataset_name"_jobs_setup.txt
#cmd+=" -l /proj/b2011117/private/gatkbp/101CRC_test/101CRC"
eval "$cmd"
