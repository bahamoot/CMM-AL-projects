#!/bin/bash
 
cmd="pyCMM-dnaseq-pipeline "
cmd+=" -j $CMM_CLIENT/scripts/gatkbp/CHEK2_BRCA_CRC/CHEK2_BRCA_CRC_jobs_setup.txt"
#cmd+=" -l /proj/b2011117/private/gatkbp/Ill_Br/Ill_Br"
eval "$cmd"
