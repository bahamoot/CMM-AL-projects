#!/bin/bash
 
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="Young_vs_FamCRCs"
cmd="pyCMM-mutrepdb-controller"
cmd+=" -j $script_dir/$dataset_name"_jobs_setup.txt
eval "$cmd"

dataset_name="Young_vs_FamBRCs"
cmd="pyCMM-mutrepdb-controller"
cmd+=" -j $script_dir/$dataset_name"_jobs_setup.txt
eval "$cmd"
