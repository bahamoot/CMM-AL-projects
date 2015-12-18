#!/bin/bash 
 
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-mutrep-mutation-reports"
cmd+=" -j $CMM_CLIENT/scripts/RnD/gen_mutation_reports/gen_mutation_reports_jobs_setup.txt"
#cmd+=" -r 18"
#cmd+=" -r 6:78171941-78172992,18:28610988-28611790"
#cmd+=" -o /proj/b2011117/private/projects/out/RnD/gen_mutation_reports/rpts/gen_mutation_reports_summary_custom.xlsx"
#cmd+=" -l /proj/b2011117/private/projects/out/RnD/gen_mutation_reports/18q_axq"
eval "$cmd"
