#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


out_dir="$script_dir/../out/"

vcf_tabix_file=$VCF_WES294

header="#CHROM\tPOS\tREF\tALT"
sample_ids=`vcf-query -l $vcf_tabix_file`
for sample_id in $sample_ids
do
    header+="\t$sample_id"
done
echo -e "$header"

out_prefix="$out_dir/WES_GT_chr"
query_format='%CHROM\t%POS\t%REF\t%ALT[\t%GT]\n'
for chrom in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 MT X Y
do
    echo -e "$header" > $out_file
    out_file=$out_prefix$chrom.txt
    cmd="vcf-query"
    cmd+=" -r $chrom"
    cmd+=" -f \"$query_format\""
    cmd+=" $vcf_tabix_file"
    cmd+=" >> $out_file"
    echo $cmd
#    eval $cmd
#    out_file=$out_prefix"_chr"$chrom.txt
#    echo -e "#Chr\tStart\tEnd\tRef\tAlt\t$header_prefix"_PF"\t$header_prefix"_GF > $out_file
#     cmd="grep -P \"^$chrom\\t\" $input | uniq  > $out_file"
#    cmd="grep -P \"^$chrom\\t\" $input | uniq | awk -F'\t' '{ printf \"%s\t%s\t%s\t%s\t%s\t%s\t%s\n\", \$1,\$2,\$3,\$4,\$5,\$14,\$12 }' >> $out_file"
done

#function extract_AF {
#    input=$1
#    out_prefix=$2
#    header_prefix=$3
#
#    #ChrStartEndRefAltWES294_OAF_BRCS_WTWES294_OAF_BRCS_HETWES294_OAF_BRCS_HOMWES294_OAF_BRCS_OTHWES294_OAF_BRCS_NAWES294_OAF_BRCS_GTWES294_OAF_BRCS_GFWES294_OAF_BRCS_AFWES294_OAF_BRCS_PF
#    for chrom in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 MT X Y
#    do
#        out_file=$out_prefix"_chr"$chrom.txt
#        echo -e "#Chr\tStart\tEnd\tRef\tAlt\t$header_prefix"_PF"\t$header_prefix"_GF > $out_file
##        cmd="grep -P \"^$chrom\\t\" $input | uniq  > $out_file"
#        cmd="grep -P \"^$chrom\\t\" $input | uniq | awk -F'\t' '{ printf \"%s\t%s\t%s\t%s\t%s\t%s\t%s\n\", \$1,\$2,\$3,\$4,\$5,\$14,\$12 }' >> $out_file"
#        echo $cmd
#        eval $cmd
#    done
##    grep -P "^1\t" /proj/b2011117/private/databases/third_party/annovar/humandb/hg19_CMM_WES294_OAF_CRCs.txt | uniq | head | awk -F'\t' '{ print $14,$12 }' 
#
#}
#
#
#extract_AF /proj/b2011117/private/databases/third_party/annovar/humandb/hg19_CMM_WES294_OAF_CRCs.txt $out_dir/PF_GF_CRC WES294_OAF_CRCS
#extract_AF /proj/b2011117/private/databases/third_party/annovar/humandb/hg19_CMM_WES294_OAF_BrCs.txt $out_dir/PF_GF_BrC WES294_OAF_BRCS
#extract_AF /proj/b2011117/private/databases/third_party/annovar/humandb/hg19_CMM_WES294_OAF_BrC_CRC_prostate.txt $out_dir/PF_GF_BrC_CRC_prostate WES294_OAF_BRC_CRC_PROSTATE
