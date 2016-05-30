#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fastq_files="$script_dir/resources/group1/S_Sample_w_indel_1/DNASeq_w_indel_S1_R1.fastq.gz"
fastq_files+=",$script_dir/resources/group1/S_Sample_w_indel_1/DNASeq_w_indel_S1_R2.fastq.gz"
reference_file="$REFERENCE_DATA_DIR/Homo_sapiens.GRCh37.57.dna.concat.fa"
known_indels_files="$REFERENCE_DATA_DIR/1000G_phase1.indels.b37.vcf"
known_indels_files+=",$REFERENCE_DATA_DIR/Mills_and_1000G_gold_standard.indels.b37.vcf"
dbsnp_file="$REFERENCE_DATA_DIR/dbsnp_138.b37.vcf"
targets_interval_list="$script_dir/targets.interval_list"
sample_group="group1"
sample_id="sample_S"
#working_dir="$script_dir/tmp"
bam_dir="$script_dir/out/bam"
out_recal_bam="$bam_dir/$sample_id".dedup.realigned.recal.bam
gvcf_dir="$script_dir/out/gvcf"
out_gvcf="$gvcf_dir/$sample_id".g.vcf.gz

#project_out_dir="$GATK_BESTPRACTICE_OUTPUT_DIR/RnD/$dataset_name"
#samples_root_dir="$script_dir/resources"
#known_indels_file1="$REFERENCE_DATA_DIR/1000G_phase1.indels.b37.vcf"
#known_indels_file2="$REFERENCE_DATA_DIR/Mills_and_1000G_gold_standard.indels.b37.vcf"
#jobs_setup_file="$dataset_name"_jobs_setup.txt
#indel_recal=True
#variants_calling=True

cmd="$PYCMM/bash/GATKBP_preprocess_sample.sh"
cmd+=" -I $fastq_files"
cmd+=" -R $reference_file"
cmd+=" -k $known_indels_files"
cmd+=" -d $dbsnp_file"
if [ ! -z $targets_interval_list ]
then
    cmd+=" -L $targets_interval_list"
fi
cmd+=" -g $sample_group"
cmd+=" -n $sample_id"
if [ ! -z $working_dir ] 
then
    cmd+=" -w $working_dir"
fi
cmd+=" -b $out_recal_bam"
cmd+=" -o $out_gvcf"

eval "$cmd"
