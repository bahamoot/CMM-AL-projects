#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="fam242_all_genes"
project_out_dir="/proj/b2011117/private/projects/out/fam242"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Uppsala_b2011117/Uppsala_realigned_58_families.vcf.gz"
#vcf_region="5,19"
project_code="b2011097"
annotated_vcf_tabix="/glob/jessada/private/master_data/CMM/table_annovar/101CRC/101CRC_annotated.vcf.gz"
#sample_infos="185:Co-603:Co-669,296:Co-793:Co-876,578:531-04o:Co-1349,650:398-05o:729-05o,740:602-05o:Co-1373:Co-1383,1213:Co-1666,1252:Co-1719"
report_regions="3:137780831-137834661,3:142534763-142608045,3:151143171-151176497,3:151591430-151602408,9:107331448-107332412,9:111934255-112083245,9:139334547-139378212,9:139388895-139440315,12:10954130-10955227,22:30727976-30752937,22:30950621-30970575,22:38093010-38172564"
call_detail="True"
#split_chrom=True
#summary_families=True
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
