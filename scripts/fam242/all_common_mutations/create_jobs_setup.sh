#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="fam242"
project_out_dir="/proj/b2011117/private/projects/out/fam242/all_common_mutations/"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Uppsala_b2011117/NK64_PMS2_sporadic_fam24.vcf.gz"
#vcf_region="5,19"
project_code="b2011097"
anno_excl_tags="Axeq_chr3_6_14_18,Axeq_chr5_19,CRC_101,CRC_CAFAM,CRC_Colon,CRC_Rectal,Mutstat_details,LJB_score,ExAC_Other,Unknown"

filter_actions="Rare"
#filter_actions+=",Non-Intergenic"
#filter_actions+=",Non-Intronic"
#filter_actions+=",Has-Mutation"
#filter_actions+=",Has-Shared"
annotated_vcf_tabix="/glob/jessada/private/master_data/CMM/table_annovar/Ill_Br_Fam242/Ill_Br_Fam242_annotated.vcf.gz"
sample_infos="242:Co-441:Co-666:Co-771"
#report_regions="5,19"
#call_detail="True"
#split_chrom=True
#summary_families=True
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
