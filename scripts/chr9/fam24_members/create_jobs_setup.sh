#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="chr9_fam24"
project_out_dir="/proj/b2011117/private/projects/out/chr9/$dataset_name/"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Axeq_b2012247/Axeq_chr9.vcf.gz"
#vcf_region="5,19"
project_code="b2011097"
rpt_alloc_time="12:00:00"
anno_excl_tags="CRC_101,Mutstat_details,LJB_score"
filter_actions="Rare"
filter_actions+=",Non-Intergenic"
filter_actions+=",Non-Intronic"
filter_actions+=",Non-Synonymous"
filter_actions+=",Has-Mutation"
#filter_actions+=",Has-Shared"
annotated_vcf_tabix="/glob/jessada/private/master_data/CMM/table_annovar/NK64_PMS2_sporadic_fam24/NK64_PMS2_sporadic_fam24_annotated.vcf.gz"
#sample_infos="Co-166:Co-166,Co-213:Co-213"
sample_infos="24:Co-166:Co-213"
#sample_infos="Co-166,Co-213,Co-648,Co-37,Co-618,Co-1274"
report_regions="1:45794913-45806142,2:47596286-47614167,2:47630205-47710367,2:48010220-48034092,2:190648810-190742355,3:37034840-37092337,3:41240941-41281939,5:79950466-80172634,5:112043201-112181936,7:6012869-6048737,7:116312458-116438440,9:101569980-101612363,10:88516395-88684945,10:89623194-89731687,12:133200347-133264110,14:75480466-75518235,15:33010204-33026870,16:68771194-68869444,17:7571719-7590868,17:63524682-63557740,18:48556582-48611411,19:1205797-1228434,19:50887579-50921275,22:29083730-29137822"
call_detail="True"
#split_chrom=True
summary_families=True
only_families=True
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
