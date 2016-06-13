#!/bin/bash
 
cmd="pyCMM-dnaseq-pipeline "
cmd+=" -j $CMM_CLIENT/scripts/RnD/gatkbp/split_reg/S_Reg_jobs_setup.txt"
#cmd+=" -l /proj/b2011117/private/gatkbp/Ill_Br/Ill_Br"
eval "$cmd"
