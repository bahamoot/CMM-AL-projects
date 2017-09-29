#!/bin/bash
 
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrepdb-seq-report"
cmd+=" -j $script_dir/gen_report_jobs_setup.txt"
#cmd+=" -f 6067"
#cmd+=" -r 18"
cmd+=" -r 6:78171941-78172992,18:28610988-28611790"
cmd+=" -o $MUTATIONS_REPORTS_OUTPUT_DIR/DB/RnD/gen_report/rpts/gen_family_report_fam6067_custom.xlsx"
#cmd+=" -l /proj/b2011117/private/projects/out/RnD/gen_family_report/18q_axq"
eval "$cmd"
