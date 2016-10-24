#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="chr9_WES294_lkg"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/chr9/WES294/"
project_code="b2012247"
annotated_vcf_tabix="$ANNOTATED_WES294"
sample_infos="$script_dir/chr9.sample_infos"
anno_excl_tags="Mutstat_details"
anno_excl_tags+=",ExAC_Other"
anno_excl_tags+=",Unknown"
report_regions="1:45794913-45806142"
report_regions+=",2:47596286-47614167"
report_regions+=",2:47630205-47710367"
report_regions+=",2:48010220-48034092"
report_regions+=",2:190648810-190742355"
report_regions+=",3:37034840-37092337"
report_regions+=",3:41240941-41281939"
report_regions+=",5:79950466-80172634"
report_regions+=",5:112043201-112181936"
report_regions+=",7:6012869-6048737"
report_regions+=",7:116312458-116438440"
report_regions+=",9:101569980-101612363"
report_regions+=",10:88516395-88684945"
report_regions+=",10:89623194-89731687"
report_regions+=",12:133200347-133264110"
report_regions+=",14:75480466-75518235"
report_regions+=",15:33010204-33026870"
report_regions+=",16:68771194-68869444"
report_regions+=",17:7571719-7590868"
report_regions+=",17:63524682-63557740"
report_regions+=",18:48556582-48611411"
report_regions+=",19:1205797-1228434"
report_regions+=",19:50887579-50921275"
report_regions+=",22:29083730-29137822"
#call_info="True"
#split_chrom=True
filter_actions="Rare"
filter_actions+=",Has-Mutation"
#filter_actions+=",Has-Shared"
#freq_ratios="ExAC_ALL:0.1"
jobs_setup_file="$dataset_name"_jobs_setup.txt


cmd="pyCMM-mutrep-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
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
