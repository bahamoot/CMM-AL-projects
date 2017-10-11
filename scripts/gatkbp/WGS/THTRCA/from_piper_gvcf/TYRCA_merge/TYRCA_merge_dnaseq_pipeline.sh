#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

dataset_name="TYRCA_piper_merge"

cmd="pyCMM-dnaseq-pipeline "
cmd+=" -j $script_dir/$dataset_name"_jobs_setup.txt
#cmd+=" -l /proj/b2011117/private/gatkbp/101CRC_test/101CRC"
eval "$cmd"
