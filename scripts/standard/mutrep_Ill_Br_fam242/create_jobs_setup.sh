#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="Illumina"
project_out_dir="/proj/b2011117/private/projects/out/standard/$dataset_name/"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Scilife_b2011158/Ill_Br_Fam242.vcf.gz"
#vcf_region="5,19"
project_code="b2011158"
annotated_vcf_tabix="/glob/jessada/private/master_data/CMM/table_annovar/Ill_Br_Fam242/Ill_Br_Fam242_annotated.vcf.gz"
sample_infos="242:Co-441:Co-666:Co-771,2060:Br-690:Br-693,3028:AL-36:AL-44:Br-732,5701:Br-585:Br-588,6067:Br-397:884-99D,6094:Br-442:Br-451,6100:Br-465:Br-466,6101:Br-473,6104:Br-475:Br-477,6106:Br-484:Br-510,6123:Br-526:Br-528,6127:Br-694:Br-697:Br-702,L1056:Br-720:Br-721:Br-724,L1141:Br-652,L862:Br-706:Br-710:Br-716"
#report_regions="5,19"
call_info="True"
split_chrom=True
exclude_common=True
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
if [ "$exclude_common" = "True" ]
then
    cmd+=" --exclude_common"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
