#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

vcf_file="/proj/b2011117/INBOX/2016-18582_sorted_md_rreal_brecal_gvcf_vrecal_comb_vt_vep_parsed_snpeff_ranked_BOTH.vcf"

out_dir="$script_dir/../out"
out_file="$out_dir/Co-309.txt"

echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tCo-309" > $out_file

grep exon "$vcf_file" | grep -v "non_coding" | grep -v "upstream" | grep -v "downstream" | grep -v "synonymous_variant" | grep -P "^[0-9]" | sort -k1,1n -k2,2n -k4,4 -k5,5 >> $out_file
grep exon "$vcf_file" | grep -v "non_coding" | grep -v "upstream" | grep -v "downstream" | grep -v "synonymous_variant" | grep -vP "^[0-9]" | sort -k1,1 -k2,2n -k4,4 -k5,5 >> $out_file

