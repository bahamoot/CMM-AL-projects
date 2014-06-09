#!/bin/bash

export HOME_GLOB="/glob/jessada/"
export CMM_PROJECTS_ROOT_DIR="$HOME_GLOB/private/projects/CMM"

export CMM_PROJECTS_OUTPUT_DIR="$CMM_PROJECTS_ROOT_DIR/out"
export CMM_PROJECTS_LOG_DIR="$CMM_PROJECTS_ROOT_DIR/log"
export CMM_PROJECTS_WORKING_DIR="$CMM_PROJECTS_ROOT_DIR/tmp"

##********************************************* libray scripts *****************************************************
export LIB_SCRIPT_DIR="$HOME_GLOB/lib/CMM-Lib/scripts"
export EXEC_SCRIPT_GEN_DEFAULT_DATA="$LIB_SCRIPT_DIR/exec_script_gen_default_data.sh"
export EXEC_SCRIPT_GEN_SUMMARY_XLS="$LIB_SCRIPT_DIR/exec_script_gen_summary_xls.sh"
export EXEC_SCRIPT_GEN_PLINK_REPORTS="$LIB_SCRIPT_DIR/exec_script_gen_plink_reports.sh"
export EXEC_SCRIPT_GEN_FAMILY_XLS="$LIB_SCRIPT_DIR/exec_script_gen_family_xls.sh"
export EXEC_SCRIPT_CAL_MUTATIONS_STAT="$LIB_SCRIPT_DIR/exec_script_cal_mutations_stat.sh"
export GET_PATIENT_CODES="$LIB_SCRIPT_DIR/get_patient_codes"

##********************************************* data location *****************************************************
##set global master data location
export CMM_MASTER_DATA_ROOT_DIR="$HOME_GLOB/private/master_data/CMM"
#
##set CMM shared data location
##OAF
#export OAF_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/oaf/"
#export CMM_OAF_UPPSALA_ALL_FAM="$OAF_ROOT_DIR/uppsala_all_fam.oaf"
#export CMM_OAF_UPPSALA_REALIGNED_ALL_58FAM="$OAF_ROOT_DIR/uppsala_realigned_all_58fam.oaf"
#export CMM_OAF_SCILIFE_ILLUMINA_ALL_FAM="$OAF_ROOT_DIR/scilife_illumina_all_fam.oaf"
#export CMM_OAF_AXEQ_CHR9_ALL_FAM="$OAF_ROOT_DIR/axeq_chr9_all_fam.oaf"
##Genotype data
#export GT_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/gt/"
#export CMM_GT_BFILE_PREFIX_WITHOUT_RELATIVES="$GT_ROOT_DIR/without_relatives/AL5cnc_common"
##export CMM_GT_UPPSALA_REALIGNED_58FAM="$OAF_ROOT_DIR/uppsala_realigned_58fam.gt"

##VCF
export CMM_UPPSALA_SEQUENCE_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_Uppsala_b2011117"
#export CMM_UPPSALA_ALL_PATIENTS_BWA_GATK_GZ="$CMM_UPPSALA_SEQUENCE_ROOT_DIR/systematic/Uppsala_bwa_GATK/bwa_GATK.vcf.gz"
export CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ="$CMM_UPPSALA_SEQUENCE_ROOT_DIR/systematic/Uppsala_realigned_58_families/vcf/merged/Uppsala_realigned_58_families.vcf.gz"
export CMM_SCILIFE_ILLUMINA_SEQUENCE_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_Scilife_b2011158/"
export CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_MANS_GZ="$CMM_SCILIFE_ILLUMINA_SEQUENCE_ROOT_DIR/systematic/mans/merged/scilife_illumina_mans.vcf.gz"
#export CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_UPPSALA_GZ="$CMM_SCILIFE_ILLUMINA_SEQUENCE_ROOT_DIR/systematic/uppsala/merged/scilife_illumina_uppsala.vcf.gz"
export CMM_AXEQ_SEQUENCE_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_Axeq_b2012247/"
export CMM_AXEQ_CHR9_ALL_PATIENTS_GZ="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr9/merged/Axeq_chr9.vcf.gz"
#export CMM_AXEQ_CHR9_ALL_PATIENTS_HEADER="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr9/merged/Axeq_chr9_header.vcf"
#export CMM_AXEQ_CHR9_FOLDER="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr9/vcf/"
#export CMM_AXEQ_CHR5_19_FOLDER="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr5_19/vcf/"
#export CMM_AXEQ_CHR3_6_14_18_FOLDER="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr3_6_14_18/vcf/"
#export CMM_SCILIFE_CAPTURE_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_Scilife_b2011097/"
#export CMM_SCILIFE_CAPTURE_FAM24_PATIENTS_GZ="$CMM_SCILIFE_CAPTURE_ROOT_DIR/systematic/capture/merged/Scilife_capture_Co166_213.vcf.gz"

#VCF Genotyping data
export CMM_FAMILY_DATA_DIR="$CMM_MASTER_DATA_ROOT_DIR/family/"
export CMM_FAM_SAMPLES_CSV="$CMM_FAMILY_DATA_DIR/FAMS_SAMPLES.csv"

#PLINK
export CMM_GENOTYPING_UPPSALA_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_genotyping_Uppsala"
export CMM_GENOTYPING_UPPSALA_PROCESSED_PLINK_BIN_FILE_PREFIX="$CMM_GENOTYPING_UPPSALA_ROOT_DIR/processed/Uppsala_genotyping"
export CMM_GENOTYPING_UPPSALA_COLON_300CTRLS_WO_RELATIVES_PHENO="$CMM_GENOTYPING_UPPSALA_ROOT_DIR/pheno/colon_300ctrls_wo_relatives_pheno.txt"

#Haplotype data
export CMM_HAPLOTYPE_DIR="$CMM_MASTER_DATA_ROOT_DIR/haplotype/"
export CMM_HAPLOTYPE_FAM24_PLINK_FILE_PREFIX="$CMM_HAPLOTYPE_DIR/fam24/Haplotype_fam24"
export CMM_HAPLOTYPE_CHR9_LKG_PLINK_FILE_PREFIX="$CMM_HAPLOTYPE_DIR/chr9_lkg/chr9_lkg_haplotypes"

###********************************************* tools/scripts location *****************************************************
#set third-party tools location
export TOOLS_ROOT_DIR="$HOME_GLOB/tools/"
#set active hbvdb location
export HBVDB_TOOLS_ROOT_DIR="$TOOLS_ROOT_DIR/hbvdb"

#ANNOVAR
export ANNOVAR_ROOT_DIR="$TOOLS_ROOT_DIR/annovar"
