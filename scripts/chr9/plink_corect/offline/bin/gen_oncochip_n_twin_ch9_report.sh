#!/bin/bash 
 
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cmd="pyCMM-plink-hap-assocs-report"
cmd+=" -j $CMM_CLIENT/scripts/chr9/plink_corect/offline/bin/oncochip_n_twin_chr9_jobs_setup.txt"
cmd+=" --hap_assoc $script_dir/../data/merged.assoc.hap"
cmd+=" --snp_info $script_dir/../data/input.snp.info"
cmd+=" --out $script_dir/../out/oncochip_n_twin_chr9.xlsx"
#cmd+=" -r 18"
#cmd+=" -r 6:78171941-78172992,18:28610988-28611790"
#cmd+=" -o /proj/b2011117/private/projects/out/RnD/gen_mutation_reports/rpts/gen_mutation_reports_summary_custom.xlsx"
#cmd+=" -l /proj/b2011117/private/projects/out/RnD/gen_mutation_reports/18q_axq"
eval "$cmd"
