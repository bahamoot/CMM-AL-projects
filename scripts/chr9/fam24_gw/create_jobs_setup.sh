#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="fam24_gw"
project_out_dir="/proj/b2011117/private/projects/out/chr9/$dataset_name/"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Axeq_b2012247/Axeq_chr9.vcf.gz"
#vcf_region="5,19"
project_code="b2011097"
rpt_alloc_time="12:00:00"
anno_excl_tags="CRC_101,Mutstat_details,LJB_score"
filter_actions="Rare"
filter_actions+=",Non-Intergenic"
filter_actions+=",Non-Intronic"
filter_actions+=",Non-Upstream"
filter_actions+=",Non-Downstream"
filter_actions+=",Non-UTR"
filter_actions+=",Non-Synonymous"
filter_actions+=",Has-Mutation"
filter_actions+=",Has-Shared"
annotated_vcf_tabix="/glob/jessada/private/master_data/CMM/table_annovar/NK64_PMS2_sporadic_fam24/NK64_PMS2_sporadic_fam24_annotated.vcf.gz"
sample_infos="24:Co-166:Co-213"
#report_regions="9:98307129-105545039"
#call_detail="True"
#split_chrom=True
summary_families=True
#only_families=True
#only_summary=True
freq_ratios="1000g2014oct_all:0.2"
freq_ratios+=",ILL_BR_PF:0.3"
freq_ratios+=",ExAC_ALL:0.3"
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
if [ ! -z $rpt_alloc_time ]
then
    cmd+=" --rpt_alloc_time $rpt_alloc_time"
fi
if [ ! -z $anno_excl_tags ]
then
    cmd+=" -E $anno_excl_tags"
fi
if [ ! -z "$filter_actions" ]
then
    cmd+=" --filter_actions $filter_actions"
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
