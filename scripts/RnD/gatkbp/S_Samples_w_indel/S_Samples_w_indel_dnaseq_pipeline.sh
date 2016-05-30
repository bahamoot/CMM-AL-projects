#!/bin/bash
 
cmd="pyCMM-dnaseq-pipeline "
cmd+=" -j $CMM_CLIENT/scripts/RnD/gatkbp/S_Samples_w_indel/S_Samples_w_indel_jobs_setup.txt"
#cmd+=" -l /proj/b2011117/private/gatkbp/Ill_Br/Ill_Br"
eval "$cmd"
