#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="axeq_chr5_19"
sample_group="1303AHS-0016"
jobs_setup_file="$dataset_name"_jobs_setup.txt
echo "##DATASET_NAME=$dataset_name" > $jobs_setup_file
echo "##PROJECT_CODE=b2011097" >> $jobs_setup_file
echo "##REFERENCE=/glob/jessada/private/master_data/reference/Homo_sapiens.GRCh37.57.dna.concat.fa" >> $jobs_setup_file
echo "##KNOWN_INDELS=/glob/jessada/private/master_data/GATK_BestPractice_test_data/known_indels_SNPs/1000G_phase1.indels.b37.vcf,/glob/jessada/private/master_data/GATK_BestPractice_test_data/known_indels_SNPs/Mills_and_1000G_gold_standard.indels.b37.vcf" >> $jobs_setup_file
echo "##DBSNP=/glob/jessada/private/master_data/GATK_BestPractice_test_data/known_indels_SNPs/dbsnp_138.b37.vcf" >> $jobs_setup_file
echo "##OUTPUT_DIR=/proj/b2011117/nobackup/private/gatkbp/$dataset_name" >> $jobs_setup_file
echo "##VARIANTS_CALLING=YES" >> $jobs_setup_file
echo "##JOBS_REPORT_FILE=/proj/b2011117/nobackup/private/gatkbp/$dataset_name/jobs_rpt.txt" >> $jobs_setup_file
echo "##TARGETS_INTERVAL_LIST=/home/jessada/private/projects/CMM/scripts/gatkbp/$dataset_name.targets.interval_list" >> $jobs_setup_file
echo "##USAGE_MAIL=NO" >> $jobs_setup_file
echo "#SAMPLE	FASTQ1	FASTQ2	SAMPLE_GROUP	PLATFORM	LIBRARY	UNIT	USAGE_MAIL	PREPROCESS_SAMPLE" >> $jobs_setup_file

for fastq_file in *_1.fastq.gz
do
    sample_name=${fastq_file%_1.fastq.gz}
    fastq1_file=$script_dir/$sample_name"_1.fastq.gz"
    fastq2_file=$script_dir/$sample_name"_2.fastq.gz"
    echo -e "$sample_name\t$fastq1_file\t$fastq2_file\t$sample_group\tIllumina\tlib1\tunit1\tNO\tYES" >> $jobs_setup_file
done

