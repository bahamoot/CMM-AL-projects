#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="Axeq_9q_win10"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/chr9/$dataset_name/"
annotated_vcf_tabix="$ANNOTATED_AXEQ_CHR9"
#vcf_region="5,19"
project_code="b2011097"
anno_excl_tags="Axeq_chr5_19"
anno_excl_tags+=",Axeq_chr3_6_14_18"
anno_excl_tags+=",CRC_101"
anno_excl_tags+=",CRC_CAFAM"
anno_excl_tags+=",CRC_Colon"
anno_excl_tags+=",CRC_Rectal"
anno_excl_tags+=",CRC_CRC"
anno_excl_tags+=",ILL_BR"
anno_excl_tags+=",NK64"
anno_excl_tags+=",Assoc"
anno_excl_tags+=",ExAC_Other"
anno_excl_tags+=",Unknown"
anno_excl_tags+=",Mutstat_details"
anno_excl_tags+=",LJB_score"
#filter_actions="Rare"
#filter_actions+=",Has-Mutation"
sample_infos="24:Co-166:Co-213:Co-648"
sample_infos+=",8:Co-37"
sample_infos+=",275:Co-618"
sample_infos+=",478:Co-1274"
sample_infos+=",740:Co-1375"
sample_infos+=",26:Co-135"
sample_infos+=",46:Co-154"
sample_infos+=",60:Co-190"
sample_infos+=",68:Co-201"
sample_infos+=",70:Co-200"
sample_infos+=",87:Co-1179"
sample_infos+=",94:Co-238"
sample_infos+=",103:Co-257"
sample_infos+=",134:Co-553"
sample_infos+=",161:Co-809"
sample_infos+=",181:Co-352"
sample_infos+=",191:Co-384"
sample_infos+=",208:Co-1094"
sample_infos+=",221:Co-358"
sample_infos+=",227:Co-364"
sample_infos+=",231:Co-555"
sample_infos+=",237:Co-452"
sample_infos+=",242:Co-666"
sample_infos+=",254:Co-616"
sample_infos+=",288:Co-1141"
sample_infos+=",296:Co-876"
sample_infos+=",301:Co-1315"
sample_infos+=",306:Co-779"
sample_infos+=",309:Co-783"
sample_infos+=",322:Co-852"
sample_infos+=",325:Co-851"
sample_infos+=",340:Co-831"
sample_infos+=",397:Co-1123"
sample_infos+=",413:Co-1215"
sample_infos+=",415:Co-1031"
sample_infos+=",425:Co-1458"
sample_infos+=",547:Co-1621"
sample_infos+=",739:Co-1467"
sample_infos+=",869:Co-1685"
sample_infos+=",975:Co-1600"
sample_infos+=",1025:Co-1529"
sample_infos+=",1085:Co-1518"
sample_infos+=",1213:Co-1666"
sample_infos+=",1252:Co-1719"
sample_infos+=",1290:Co-1723"
sample_infos+=",Unknown:Co-1762"
#sample_infos="Co-166,Co-213,Co-648,Co-37,Co-618,Co-1274"
report_regions="9:98360213-98407526"
call_detail="False"
#split_chrom=True
summary_families=True
#only_families=True
only_summary=True
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
