#!/bin/bash
 
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-summary-report"
cmd+=" -j $CMM_CLIENT/scripts/RnD/gen_summary_report/gen_summary_report_jobs_setup.txt"
#cmd+=" -r 18"
#cmd+=" -r 6:78171941-78172992,18:28610988-28611790"
cmd+=" -r 6:57071941-78172992"
cmd+=" -o $MUTATIONS_REPORTS_OUTPUT_DIR/RnD/gen_summary_report/rpts/gen_summary_report_summary_custom.xlsx"
#cmd+=" -l /proj/b2011117/private/projects/out/RnD/gen_summary_report/18q_axq"
eval "$cmd"
