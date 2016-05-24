#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="oncochip_n_twin_chr9"
project_out_dir="$PLINK_OUTPUT_DIR/chr9/offline/$dataset_name"
#project_code="b2011097"
jobs_setup_file="$dataset_name"_jobs_setup.txt
input_dna_regions="9"
hap_window_sizes="1,3,5,10,25"
input_bfile_prefix="$GENOTYPING_ONCOCHIP_N_TWINGENE"
phenotype_file="$GENOTYPING_ONCOCHIP_N_TWINGENE_PHENOTYPE_FILE"
filter_criteria="PVALUE005"
filter_criteria+=",DISEASE_SNP"
cutoff_pvalue="0.001"
cutoff_ors="1.5"
fam_hap_prefix="$HAPLOTYPE_CHR9_LINKAGE"
sample_info="24:new_fam24_shared_only"
sample_info+=",8:fam_8"
sample_info+=",275:fam_275"
sample_info+=",350:fam_350"
sample_info+=",478:fam_478"
sample_info+=",918:fam_918"


cmd="pyCMM-plink-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
if [ ! -z $hap_window_sizes ]
then
    cmd+=" --hap-window $hap_window_sizes"
fi
if [ ! -z $input_bfile_prefix ]
then
    cmd+=" --bfile $input_bfile_prefix"
fi
if [ ! -z $input_file_prefix ]
then
    cmd+=" --file $input_file_prefix"
fi
cmd+=" --pheno $phenotype_file"
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $sample_info ]
then
    cmd+=" --sample_info $sample_info"
fi
if [ ! -z $cutoff_pvalue ]
then
    cmd+=" --cutoff_pvalue $cutoff_pvalue"
fi
if [ ! -z $cutoff_ors ]
then
    cmd+=" --cutoff_ors $cutoff_ors"
fi
if [ ! -z $input_dna_regions ]
then
    cmd+=" -R $input_dna_regions"
fi
if [ ! -z $filter_criteria ]
then
    cmd+=" --filter_criteria $filter_criteria"
fi
if [ ! -z $fam_hap_prefix ]
then
    cmd+=" --fam_hap $fam_hap_prefix"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
