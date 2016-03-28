#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="chr10"
project_out_dir="/proj/b2011117/private/projects/out/hovsep/chr10"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Uppsala_b2011117/Uppsala_realigned_58_families.vcf.gz"
#vcf_region="5,19"
project_code="b2011158"
annotated_vcf_tabix="/glob/jessada/private/master_data/CMM/table_annovar/101CRC/101CRC_annotated.vcf.gz"
sample_infos="185:Co-603:Co-669,296:Co-793:Co-876,578:531-04o:Co-1349,650:398-05o:729-05o,740:602-05o:Co-1373:Co-1383,1213:Co-1666,1252:Co-1719"
report_regions="10:62100000-69970000"
call_info="True"
#split_chrom=True
summary_families=True
#exclude_common=True
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
if [ "$call_info" == "True" ]
then
    cmd+=" --call_info"
fi
if [ ! -z $freq_ratios ]
then
    cmd+=" -f $freq_ratios"
fi
if [ "$split_chrom" == "True" ]
then
    cmd+=" --split_chrom"
fi
if [ "$summary_families" == "True" ]
then
    cmd+=" --summary_families"
fi
if [ "$exclude_common" = "True" ]
then
    cmd+=" --exclude_common"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
