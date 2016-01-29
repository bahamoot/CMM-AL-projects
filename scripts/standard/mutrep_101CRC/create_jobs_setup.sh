#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="101CRC"
project_out_dir="/proj/b2011117/private/projects/out/standard/$dataset_name/"
vcf_tabix_file="/glob/jessada/private/master_data/CMM/CMM_Uppsala_b2011117/Uppsala_realigned_58_families.vcf.gz"
#vcf_region="5,19"
project_code="b2011158"
annotated_vcf_tabix="/glob/jessada/private/master_data/CMM/table_annovar/101CRC/101CRC_annotated.vcf.gz"
sample_infos="8:Co-35:Co-37,12:Co-89:Co-90,13:Co-95,26:Co-131:Co-135,31:1793-11D:1322-11D,87:Co-218:Co-258,91:Co-454:Co-700,94:Co-238,110:1526-02D:Co-1301,134:Co-460:Co-553,141:Co-305:Co-785,185:Co-603:Co-669,191:Co-384,214:Co-484,216:Co-367:Co-446,221:Co-358,227:Co-364,231:Co-555:Co-572,254:Co-616:Co-1156,275:Co-618:Co-1262,288:Co-1141,296:Co-793:Co-876,301:Co-837:Co-840:Co-1053,306:Co-779,309:Co-783,312:Co-1116,315:1462-01D,325:Co-851:Co-859,348:Co-846:Co-857,350:1104-03D:Co-866,409:Co-1254,415:Co-1031:Co-1037,425:Co-1458:Co-1595,434:Co-1051:Co-1534,445:Co-1157:Co-1158,478:Co-1207:Co-1274,485:Co-1302:Co-1322,532:Co-1583:Co-1584,574:468-04:474-05,578:531-04o:Co-1349,650:398-05o:729-05o,695:Co-1354:Co-1359:Co-1368,739:529-05:Co-1467,740:602-05o:Co-1373:Co-1383,849:Co-1764:Co-1765,869:Co-1685,871:Co-1618:Co-1661,918:134-06:354-06,975:Co-1591:Co-1600,1025:Co-1529,1085:Co-1518,1113:642-06:Co-1538,1206:1052-05D:Co-1552,1207:2818-07D,1213:Co-1666,1252:Co-1719,1290:Co-1723,prostate:P001:P002:P003"
#report_regions="5,19"
call_detail="True"
split_chrom=True
exclude_common=True
exclude_intergenic=True
exclude_intronic=True
only_summary=True
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
if [ "$only_summary" = "True" ]
then
    cmd+=" --only_summary"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
