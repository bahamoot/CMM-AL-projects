#!/bin/bash

module load annovar
source $PYCMM/bash/cmm_functions.sh
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

vcf_one_sample="/proj/b2011117/private/raw_exome_sequencing_data/one_extra_PMS2/delivered/Co-309.vcf.gz"

function get_tmp_vcf_file_name {
    tmp_prefix=`mktemp`
    echo $tmp_prefix.vcf
}

function gtz_vcf {
    input_vcf=$1
    output_vcf=$2

    tabix -h $input_vcf 1:1-1 | sed 's/LEI1904A1/Co-309/' | sed 's/Number=R/Number=./' > $output_vcf
    for chrom in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y
    do
        cmd="tabix $input_vcf $chrom | cut -f1-5,9-10 | awk -F'\t' '{ printf \"%s\t%s\t%s\t%s\t%s\t.\t.\t.\t%s\t%s\n\", \$1, \$2, \$3, \$4, \$5, \$6, \$7 }' >> $output_vcf"
        eval_cmd "$cmd"
    done
#    tabix $input_vcf 10:89600000-89690000 | cut -f1-5,9-10 | awk -F'\t' '{ printf "%s\t%s\t%s\t%s\t%s\t.\t.\t.\t%s\t%s\n", $1, $2, $3, $4, $5, $6, $7 }'>> $output_vcf
#    tabix $input_vcf 10:89680000-89690000 | cut -f1-5 | awk -F'\t' '{ printf "%s\t.\tPASS\t.\tGT\t0\\1\n", $0 }'>> $output_vcf
#    tabix -h $input_vcf 10:89680000-89690000 | cut -f1-9 > $output_vcf
#    bgzip -f $output_vcf
#    tabix -f -p vcf $output_vcf.gz
}


gtz_vcf_one_sample="$script_dir/gtz_Co-309.vcf"
echo $empty_vcf_one_sample
#
#
gtz_vcf "$vcf_one_sample" "$gtz_vcf_one_sample"
#zgrep -v "^#" "$gtz_vcf_one_sample" | wc -l

bgzip -f $gtz_vcf_one_sample
tabix -f -p vcf $gtz_vcf_one_sample.gz
