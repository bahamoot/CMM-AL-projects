#!/bin/bash

export HOME_GLOB="/glob/jessada/"
export CMM_PROJECTS_ROOT_DIR="$HOME_GLOB/private/projects/CMM"

export CMM_PROJECTS_OUTPUT_DIR="$CMM_PROJECTS_ROOT_DIR/out"
export CMM_PROJECTS_SLURM_LOG_DIR="$CMM_PROJECTS_ROOT_DIR/slurm_log"
export CMM_PROJECTS_WORKING_DIR="$CMM_PROJECTS_ROOT_DIR/tmp"

##********************************************* libray scripts *****************************************************
export CMM_LIB_ROOT_DIR="/home/jessada/CMM-Lib/"
#export CMM_LIB_ROOT_DIR="$HOME_GLOB/lib/CMM-Lib/"
#export CMM_LIB_ROOT_DIR="$HOME_GLOB/lib/CMM-Lib/dev/scripts"
#export EXEC_SCRIPT_GEN_DEFAULT_DATA="$CMM_LIB_DIR/exec_script_gen_default_data.sh"
#export EXEC_SCRIPT_GEN_SUMMARY_XLS="$CMM_LIB_DIR/exec_script_gen_summary_xls.sh"
#export EXEC_SCRIPT_GEN_PLINK_REPORTS="$CMM_LIB_DIR/exec_script_gen_plink_reports.sh"
#export EXEC_SCRIPT_GEN_FAMILY_XLS="$CMM_LIB_DIR/exec_script_gen_family_xls.sh"
#export EXEC_SCRIPT_GEN_MUTATIONS_REPORTS="$CMM_LIB_DIR/exec_script_gen_mutations_reports.sh"
#export EXEC_SCRIPT_CAL_MUTATIONS_STAT="$CMM_LIB_DIR/exec_script_cal_mutations_stat.sh"
#export GET_PATIENT_CODES="$CMM_LIB_DIR/get_patient_codes"

##********************************************* data location *****************************************************
##set global master data location
export CMM_MASTER_DATA_ROOT_DIR="$HOME_GLOB/private/master_data/CMM"
#
##set CMM shared data location
##VCF
export CMM_UPPSALA_SEQUENCE_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_Uppsala_b2011117"
#export CMM_UPPSALA_ALL_PATIENTS_BWA_GATK_GZ="$CMM_UPPSALA_SEQUENCE_ROOT_DIR/systematic/Uppsala_bwa_GATK/bwa_GATK.vcf.gz"
export CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ="$CMM_UPPSALA_SEQUENCE_ROOT_DIR/systematic/Uppsala_realigned_58_families/vcf/merged/Uppsala_realigned_58_families.vcf.gz"
export CMM_SCILIFE_ILLUMINA_SEQUENCE_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_Scilife_b2011158/"
export CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_MANS_GZ="$CMM_SCILIFE_ILLUMINA_SEQUENCE_ROOT_DIR/systematic/mans/merged/scilife_illumina_mans.vcf.gz"
#export CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_UPPSALA_GZ="$CMM_SCILIFE_ILLUMINA_SEQUENCE_ROOT_DIR/systematic/uppsala/merged/scilife_illumina_uppsala.vcf.gz"
export CMM_AXEQ_SEQUENCE_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_Axeq_b2012247/"
export CMM_AXEQ_CHR9_ALL_PATIENTS_GZ="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr9/merged/Axeq_chr9.vcf.gz"
export CMM_AXEQ_CHR5_19_ALL_PATIENTS_GZ="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr5_19/merged/Axeq_chr5_19.vcf.gz"
export CMM_VINAY_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/vinay/"
export CMM_VINAY_AXEQ_GZ="$CMM_VINAY_ROOT_DIR/merged/Axeq-vinay.vcf.gz"
export CMM_AXEQ_CHR3_6_14_18_ALL_PATIENTS_GZ="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr3_6_14_18/merged/Axeq_chr3_6_14_18.vcf.gz"
#export CMM_AXEQ_CHR9_FOLDER="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr9/vcf/"
#export CMM_AXEQ_CHR5_19_FOLDER="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr5_19/vcf/"
#export CMM_AXEQ_CHR3_6_14_18_FOLDER="$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr3_6_14_18/vcf/"
#export CMM_SCILIFE_CAPTURE_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_Scilife_b2011097/"
#export CMM_SCILIFE_CAPTURE_FAM24_PATIENTS_GZ="$CMM_SCILIFE_CAPTURE_ROOT_DIR/systematic/capture/merged/Scilife_capture_Co166_213.vcf.gz"

# stat data
export SWEDES_STAT="$HOME_GLOB/private/master_data/249swedes/stat/swedes.stat"

# group of patients by syndromes
export CMM_FAMILY_DATA_DIR="$CMM_MASTER_DATA_ROOT_DIR/family/processed"
export CMM_FAMILY_DATA_UPPSALA_DIR="$CMM_FAMILY_DATA_DIR/uppsala/"
export CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_CAFAM="$CMM_FAMILY_DATA_UPPSALA_DIR/uppsala_pats_all_members.lst.CAFAM"
export CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_NON_CAFAM="$CMM_FAMILY_DATA_UPPSALA_DIR/uppsala_pats_all_members.lst.NON_CAFAM"
export CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_CRC="$CMM_FAMILY_DATA_UPPSALA_DIR/uppsala_pats_all_members.lst.CRC"
export CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_NON_CRC="$CMM_FAMILY_DATA_UPPSALA_DIR/uppsala_pats_all_members.lst.NON_CRC"
export CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_COLON="$CMM_FAMILY_DATA_UPPSALA_DIR/uppsala_pats_all_members.lst.COLON"
export CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_NON_COLON="$CMM_FAMILY_DATA_UPPSALA_DIR/uppsala_pats_all_members.lst.NON_COLON"
export CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_RECTAL="$CMM_FAMILY_DATA_UPPSALA_DIR/uppsala_pats_all_members.lst.RECTAL"
export CMM_PATIENT_LIST_UPPSALA_ALL_MEMBERS_NON_RECTAL="$CMM_FAMILY_DATA_UPPSALA_DIR/uppsala_pats_all_members.lst.NON_RECTAL"
export CMM_FAM_SAMPLES_CSV="$CMM_FAMILY_DATA_DIR/FAMS_SAMPLES.csv"

# phenotype files
export CMM_FAMILY_PHENOTYPE_UPPSALA="$CMM_FAMILY_DATA_UPPSALA_DIR/uppsala_fam_phenotype.txt"
export CMM_PATIENT_PHENOTYPE_UPPSALA="$CMM_FAMILY_DATA_UPPSALA_DIR/uppsala_pat_phenotype.txt"

#PLINK
export CMM_GENOTYPING_UPPSALA_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_genotyping_Uppsala"
export CMM_GENOTYPING_UPPSALA_PROCESSED_PLINK_BIN_FILE_PREFIX="$CMM_GENOTYPING_UPPSALA_ROOT_DIR/processed/GT_Merged_QC_Cases_n_Cntrls"
export CMM_GENOTYPING_UPPSALA_COLON_301CTRLS_WO_RELATIVES_PHENO="$CMM_GENOTYPING_UPPSALA_ROOT_DIR/pheno/colon_301ctrls_wo_relatives_pheno.txt"
export CMM_GENOTYPING_UPPSALA_BREAST_301CTRLS_WO_RELATIVES_PHENO="$CMM_GENOTYPING_UPPSALA_ROOT_DIR/pheno/breast_301ctrls_wo_relatives_pheno.txt"
export CMM_GENOTYPING_UPPSALA_CRC_LKG_W_RELATIVES_PHENO="$CMM_GENOTYPING_UPPSALA_ROOT_DIR/pheno/CRC_linkage_w_relatives_pheno.txt"
export CMM_GENOTYPING_UPPSALA_ICF_TOP_STAT="$CMM_GENOTYPING_UPPSALA_ROOT_DIR/res/LC-0028_130215_ResultReport_GenotypingStatistics_ICF_TOP.tab.txt"
export CMM_GENOTYPING_UPPSALA_PCF_TOP_STAT="$CMM_GENOTYPING_UPPSALA_ROOT_DIR/res/LC-0028_130215_ResultReport_GenotypingStatistics_PCF_TOP.tab.txt"
export CMM_GENOTYPING_TWIN_AL_ROOT_DIR="$CMM_MASTER_DATA_ROOT_DIR/CMM_genotyping_Twin_AL"
export CMM_GENOTYPING_TWIN_AL_PROCESSED_PLINK_BIN_FILE_PREFIX="$CMM_GENOTYPING_TWIN_AL_ROOT_DIR/Twin+AL_CRC_QC_3rd_QC"
export CMM_GENOTYPING_TWIN_AL_CRC_PHENO="$CMM_GENOTYPING_TWIN_AL_ROOT_DIR/pheno_crc_ctrl.txt"

#Haplotype data
export CMM_HAPLOTYPE_DIR="$CMM_MASTER_DATA_ROOT_DIR/haplotype/"
export CMM_HAPLOTYPE_FAM24_PLINK_FILE_PREFIX="$CMM_HAPLOTYPE_DIR/fam24/Haplotype_fam24"
export CMM_HAPLOTYPE_CHR9_LKG_PLINK_FILE_PREFIX="$CMM_HAPLOTYPE_DIR/chr9_lkg/chr9_lkg_haplotypes"

#GATK
#export KNOWN_INDELS_1000G_PHASE1="$HOME_GLOB/private/master_data/known_indels_SNPs/1000G_phase1.indels.b37.vcf"
#export KNOWN_INDELS_MILLS_AND_1000G_GOLD_STANDARD="$HOME_GLOB/private/master_data/known_indels_SNPs/Mills_and_1000G_gold_standard.indels.b37.vcf"
#export REFERENCE="$HOME_GLOB/private/master_data/reference/Homo_sapiens.GRCh37.57.dna.concat.fa"

###********************************************* tools/scripts location *****************************************************
#set third-party tools location
export TOOLS_ROOT_DIR="$HOME_GLOB/tools/"
#set active hbvdb location
export HBVDB_TOOLS_ROOT_DIR="$TOOLS_ROOT_DIR/hbvdb"

#ANNOVAR
export ANNOVAR_ROOT_DIR="$TOOLS_ROOT_DIR/annovar"
