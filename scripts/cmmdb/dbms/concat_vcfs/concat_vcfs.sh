#!/bin/bash

module load annovar
source $PYCMM/bash/cmm_functions.sh
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

vcf_one_sample="/proj/b2011117/private/raw_exome_sequencing_data/one_extra_PMS2/delivered/Co-309.vcf.gz"

function get_tmp_vcf_file_name {
    tmp_prefix=`mktemp`
    echo $tmp_prefix.vcf
}

function create_empty_vcf {
    input_vcf=$1
    output_vcf=$2

    echo "##fileformat=VCFv4.2" > $output_vcf
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO" >> $output_vcf
#    echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tdummy" >> $output_vcf
    for chrom in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y
    do
        cmd="tabix $input_vcf $chrom | cut -f1-5 | awk -F'\t' '{ printf \"%s\t.\t.\t.\n\", \$0 }' >> $output_vcf"
        eval_cmd "$cmd"
    done
#    tabix $input_vcf 10:89680000-89690000 | cut -f1-5 | awk -F'\t' '{ printf "%s\t.\t.\t.\n", $0 }'>> $output_vcf
#    tabix $input_vcf 10:89680000-89690000 | cut -f1-5 | awk -F'\t' '{ printf "%s\t.\tPASS\t.\tGT\t0\\1\n", $0 }'>> $output_vcf
#    tabix -h $input_vcf 10:89680000-89690000 | cut -f1-9 > $output_vcf
    bgzip -f $output_vcf
    tabix -f -p vcf $output_vcf.gz
}


#empty_vcf_WES294="$script_dir/empty_vcf_WES294.vcf"
#echo $empty_vcf_WES294
#empty_vcf_THYRCA="$script_dir/empty_vcf_THYRCA.vcf"
#echo $empty_vcf_THYRCA
#empty_vcf_one_sample="$script_dir/empty_vcf_one_sample.vcf"
#echo $empty_vcf_one_sample
##empty_vcf_WES294="$TMPDIR/abc.vcf"
##empty_vcf_THYRCA="$TMPDIR/def.vcf"
#
#
#create_empty_vcf "$VCF_WES294" "$empty_vcf_WES294"
#zgrep -v "^#" "$empty_vcf_WES294" | wc -l
#create_empty_vcf "$VCF_THYRCA" "$empty_vcf_THYRCA"
#zgrep -v "^#" "$empty_vcf_THYRCA" | wc -l
#create_empty_vcf "$vcf_one_sample" "$empty_vcf_one_sample"
#zgrep -v "^#" "$empty_vcf_one_sample" | wc -l

function concat_vcf {
    vcf1=$1
    vcf2=$2

    tmp_concat=`get_tmp_vcf_file_name`
    grep -v "^#" $vcf1 > $tmp_concat
    grep -v "^#" $vcf2 >> $tmp_concat

    sort $tmp_concat -k2,2n | uniq
}


#concated_vcf=`get_tmp_vcf_file_name`
#echo $concated_vcf
#echo "##fileformat=VCFv4.2" > "$concated_vcf"
#echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO" >> "$concated_vcf"
##echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tdummy" >> "$concated_vcf"
#concat_vcf "$empty_vcf_WES294" "$empty_vcf_THYRCA" >> "$concated_vcf"
##vcf-concat  "$empty_vcf_WES294.gz" "$empty_vcf_THYRCA.gz" > "$concated_vcf"
##vcf-sort "$concated_vcf" | grep -v "^#" | wc -l
#grep -v "^#"  "$concated_vcf" | wc -l
#bgzip -f $concated_vcf
#tabix -f -p vcf $concated_vcf.gz

concated_vcf="$script_dir/all_coors.vcf"

tmp_ta_prefix=`mktemp`
table_annovar_cmd="table_annovar.pl"
table_annovar_cmd+=" $concated_vcf.gz"
table_annovar_cmd+=" $ANNOVAR_HUMAN_DB_DIR"
table_annovar_cmd+=" -buildver hg19"
table_annovar_cmd+=" -out $tmp_ta_prefix"
#table_annovar_cmd+=" -remove"
#table_annovar_cmd+=" -protocol 1000g2014oct_all,snp138,CMM_Axeq_chr5_19,CMM_oncoarray_gw,CMM_dummy_test,CMM_OAF_BrC_CRC_prostate"
#-protocol refGene,cytoBand,exac03,avsnp147,dbnsfp30a -operation gx,r,r,r,r,f
table_annovar_cmd+=" -protocol refGene,cytoBand,targetScanS,wgRna,tfbsConsSites,exac03constraint,1000g2014oct_all,1000g2014oct_eur"
#table_annovar_cmd+=" -protocol gff3,exac03constraint,1000g2014oct_all,intervar"
#table_annovar_cmd+=" -protocol gff3,exac03constraint,1000g2014oct_all,CMM_OAF_BrC_CRC_prostate,intervar"
#table_annovar_cmd+=" -protocol 1000g2014oct_all,snp138,CMM_Axeq_chr5_19,CMM_oncoarray_gw,CMM_dummy_test"
table_annovar_cmd+=" -operation g,r,r,r,r,r,f,f"
#table_annovar_cmd+=" -operation r,r,f,f"
#table_annovar_cmd+=" --gff3dbfile test_gff2.gff"
#table_annovar_cmd+=" --gff3dbfile hg19_example_db_gff3.txt"
#table_annovar_cmd+=" --argument ,,,,"
table_annovar_cmd+=" -nastring ."
table_annovar_cmd+=" -vcfinput"
eval_cmd "$table_annovar_cmd"

#tabix $VCF_WES294 10:89680000-89690000 | cut -f1-8
#echo
#tabix $VCF_THYRCA 10:89680000-89690000 | cut -f1-2

#project_name="prototype"
#project_out_dir="$CMMDB_OUTPUT_DIR/SQLiteDB/$project_name"
##sample_info="$SAMPLES_LIST_DIR/Exome_OAF_familial_CRC.list"
##sample_info="/glob/jessada//private/master_data/CMM/family/processed/uppsala//uppsala_pats_all_members.lst.all"
#project_code="b2016331"
#job_alloc_time="2:00:00"
#db_file="$SQLITE_DB_GRCH37"
#db_jobs="$script_dir/small_db.jobs"
#jobs_setup_file=dbms_"$project_name"_jobs_setup.txt
#
#
#cmd="pyCMM-dbms-create-job-setup-file"
#cmd+=" -d $project_name"
#cmd+=" -O $project_out_dir"
#if [ ! -z $project_code ]
#then
#    cmd+=" -p $project_code"
#fi
#if [ ! -z $job_alloc_time ]
#then
#    cmd+=" --job_alloc_time $job_alloc_time"
#fi
#if [ ! -z $db_file ]
#then
#    cmd+=" --db_file $db_file"
#fi
#if [ ! -z $db_jobs ]
#then
#    cmd+=" --db_jobs $db_jobs"
#fi
#cmd+=" -o $jobs_setup_file"
#
#eval "$cmd"
