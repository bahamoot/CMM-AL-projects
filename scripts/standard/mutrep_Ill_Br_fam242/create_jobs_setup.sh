#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="Illumina"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/standard/$dataset_name/"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Scilife_b2011158/Ill_Br_Fam242.vcf.gz"
#vcf_region="5,19"
project_code="b2011097"
annotated_vcf_tabix="$ANNOTATED_ILL_BR_FAM242"
sample_infos="242:Co-441:Co-666:Co-771,2060:Br-690:Br-693,3028:AL-36:AL-44:Br-732,5701:Br-585:Br-588,6067:Br-397:884-99D,6094:Br-442:Br-451,6100:Br-465:Br-466,6101:Br-473,6104:Br-475:Br-477,6106:Br-484:Br-510,6123:Br-526:Br-528,6127:Br-694:Br-697:Br-702,L1056:Br-720:Br-721:Br-724,L1141:Br-652,L862:Br-706:Br-710:Br-716"
#report_regions="5,19"
call_info="True"
split_chrom=True
filter_actions="Rare"
#filter_actions+=",Non-Intergenic"
#filter_actions+=",Non-Intronic"
#filter_actions+=",Has-Mutation"
#filter_actions+=",Has-Shared"
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
