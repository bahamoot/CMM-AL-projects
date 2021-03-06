#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="chr9_NK64"
project_out_dir="/proj/b2011117/private/projects/out/chr9/$dataset_name/"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Axeq_b2012247/Axeq_chr9.vcf.gz"
#vcf_region="5,19"
project_code="b2011158"
anno_excl_tags="Axeq_chr5_19,Axeq_chr3_6_14_18,CRC_101,Mutstat_details,LJB_score"
rows_filter="Rare"
rows_filter+=",Non-Intergenic"
rows_filter+=",Non-Intronic"
rows_filter+=",Has-Mutation"
rows_filter+=",Has-Shared"
annotated_vcf_tabix="/glob/jessada/private/master_data/CMM/table_annovar/NK64_PMS2_sporadic_fam24/NK64_PMS2_sporadic_fam24_annotated.vcf.gz"
sample_infos="24:Co-166:Co-213"
#sample_infos="Co-166,Co-213,Co-648,Co-37,Co-618,Co-1274"
report_regions="9:98307129-105545039"
call_detail="True"
#split_chrom=True
summary_families=True
#only_families=True
#only_summary=True
#freq_ratios="ExAC_ALL:0.1"
jobs_setup_file="$dataset_name"_jobs_setup.txt


cmd="pyCMM-cmmdb-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
cmd+=" -i $vcf_tabix_file"
if [ ! -z $vcf_region ]
then
    cmd+=" -r $vcf_region"
fi
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $anno_excl_tags ]
then
    cmd+=" -E $anno_excl_tags"
fi
if [ ! -z "$rows_filter" ]
then
    cmd+=" -F $rows_filter"
fi
if [ ! -z $annotated_vcf_tabix ]
then
    cmd+=" -A $annotated_vcf_tabix"
fi
if [ ! -z $sample_infos ]
then
    cmd+=" -s $sample_infos"
fi
if [ ! -z $report_regions ]
then
    cmd+=" -R $report_regions"
fi
if [ "$call_detail" == "True" ]
then
    cmd+=" --call_detail"
fi
if [ ! -z $freq_ratios ]
then
    cmd+=" -f $freq_ratios"
fi
if [ "$split_chrom" == "True" ]
then
    cmd+=" --split_chrom"
fi
if [ "$summary_families" = "True" ]
then
    cmd+=" --summary_families"
fi
if [ "$exclude_common" = "True" ]
then
    cmd+=" --exclude_common"
fi
if [ "$exclude_intergenic" = "True" ]
then
    cmd+=" --exclude_intergenic"
fi
if [ "$exclude_intronic" = "True" ]
then
    cmd+=" --exclude_intronic"
fi
if [ "$only_families" = "True" ]
then
    cmd+=" --only_families"
fi
if [ "$only_summary" = "True" ]
then
    cmd+=" --only_summary"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
