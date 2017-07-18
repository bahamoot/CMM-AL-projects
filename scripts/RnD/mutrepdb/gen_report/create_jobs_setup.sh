#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="gen_report"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/DB/RnD/$dataset_name"
#project_code="b2011097"
db_file="$SQLITE_DB_GRCH37"
call_detail="True"
sample_infos="$script_dir/sample.info"
#freq_ratios="ExAC_ALL:0.1"
show_shared_variants="True"
jobs_setup_file="$dataset_name"_jobs_setup.txt


cmd="pyCMM-mutrepdb-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $db_file ]
then
    cmd+=" -A $db_file"
fi
if [ ! -z $report_regions ]
then
    cmd+=" -R $report_regions"
fi
if [ ! -z $sample_infos ]
then
    cmd+=" -s $sample_infos"
fi
if [ "$call_detail" == "True" ]
then
    cmd+=" --call_detail"
fi
if [ ! -z $freq_ratios ]
then
    cmd+=" -f $freq_ratios"
fi
if [ "$split_chrom" == "True" ]
then
    cmd+=" --split_chrom"
fi
if [ "$summary_families" == "True" ]
then
    cmd+=" --summary_families"
fi
if [ "$exclude_common" = "True" ]
then
    cmd+=" --exclude_common"
fi
if [ "$show_shared_variants" == "True" ]
then
    cmd+=" --show_shared_variants"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
