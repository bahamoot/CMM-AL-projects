#!/bin/bash

awk -F'\t' '{
if ($4 == "No" && $3 == "Colon") 
    printf "%s\t%s\t2\n", $1, $2;
else if ($3 == "None") 
    printf "%s\t%s\t1\n", $1, $2;
}' $CMM_GENOTYPING_UPPSALA_PHENOTYPE

