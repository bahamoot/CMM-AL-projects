#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tfam_file="/proj/b2011117/private/databases/haplotype/chr9_linkage/chr9_lkg_haplotypes.tfam"
tped_file="/proj/b2011117/private/databases/haplotype/chr9_linkage/chr9_lkg_haplotypes.tped"

out_file="$script_dir/../out/lkg_win10_haplo.txt"

#cut -f2 $tfam_file | tr "\n" "\t" > $out_file
cut -f2 $tfam_file | sed 's/$/\n/'  | tr "\n" "\t" > $out_file
echo >> $out_file


function extract_haplo_from_snp {
    snp=$1
    
    grep $snp "$tped_file" | cut --complement -f1-4 | tr " " "\t" >> $out_file
}

extract_haplo_from_snp rs928618
extract_haplo_from_snp rs10120219
extract_haplo_from_snp rs4743090
extract_haplo_from_snp rs7864457
extract_haplo_from_snp rs7854560
extract_haplo_from_snp rs7860540
extract_haplo_from_snp rs930280
extract_haplo_from_snp rs6478302
extract_haplo_from_snp rs10989496
extract_haplo_from_snp rs10989747
