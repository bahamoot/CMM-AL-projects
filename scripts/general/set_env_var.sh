#!/bin/bash

export HOME_GLOB=/glob/jessada/


##********************************************* set library *****************************************************
export LIB_SCRIPT_DIR=$HOME_GLOB/lib/CMM-Lib/scripts
export SCRIPT_GEN_OAF=$LIB_SCRIPT_DIR/script_gen_oaf.sh

##********************************************* data location *****************************************************
#set global master data location
export CMM_MASTER_DATA_ROOT_DIR=$HOME_GLOB/private/master_data/CMM

#set CMM shared data location
#hbvdb
export HBVDB_ROOT_DIR=$CMM_MASTER_DATA_ROOT_DIR/hbvdb/
export CMM_HBVDB_UPPSALA_ALL_FAM=$HBVDB_ROOT_DIR/uppsala_all_fam
export CMM_HBVDB_UPPSALA_REALIGNED_ALL_50FAM=$HBVDB_ROOT_DIR/uppsala_realigned_all_50fam
export CMM_HBVDB_SCILIFE_ILLUMINA_ALL_FAM=$HBVDB_ROOT_DIR/scilife_illumina_all_fam
export CMM_HBVDB_AXEQ_CHR9_ALL_FAM=$HBVDB_ROOT_DIR/axeq_chr9_all_fam
#OAF
export OAF_ROOT_DIR=$CMM_MASTER_DATA_ROOT_DIR/oaf/
export CMM_OAF_UPPSALA_ALL_FAM=$OAF_ROOT_DIR/uppsala_all_fam.oaf
export CMM_OAF_UPPSALA_REALIGNED_ALL_50FAM=$OAF_ROOT_DIR/uppsala_realigned_all_50fam.oaf
export CMM_OAF_SCILIFE_ILLUMINA_ALL_FAM=$OAF_ROOT_DIR/scilife_illumina_all_fam.oaf
export CMM_OAF_AXEQ_CHR9_ALL_FAM=$OAF_ROOT_DIR/axeq_chr9_all_fam.oaf
#Genotype data
export GT_ROOT_DIR=$CMM_MASTER_DATA_ROOT_DIR/gt/
export CMM_GT_UPPSALA_REALIGNED_50FAM=$OAF_ROOT_DIR/uppsala_realigned_50fam.gt
#VCF
export CMM_UPPSALA_SEQUENCE_ROOT_DIR=$CMM_MASTER_DATA_ROOT_DIR/CMM_Uppsala_b2011117
export CMM_UPPSALA_ALL_PATIENTS_BWA_GATK_GZ=$CMM_UPPSALA_SEQUENCE_ROOT_DIR/systematic/Uppsala_bwa_GATK/bwa_GATK.vcf.gz
export CMM_UPPSALA_ALL_PATIENTS_BWA_GATK_HEADER=$CMM_UPPSALA_SEQUENCE_ROOT_DIR/systematic/Uppsala_bwa_GATK/bwa_GATK_header.vcf
export CMM_UPPSALA_50FAM_ALL_PATIENTS_GZ=$CMM_UPPSALA_SEQUENCE_ROOT_DIR/systematic/Uppsala_realigned_50_families/vcf/merged/Uppsala_realigned_50_families.vcf.gz
export CMM_UPPSALA_50FAM_ALL_PATIENTS_HEADER=$CMM_UPPSALA_SEQUENCE_ROOT_DIR/systematic/Uppsala_realigned_50_families/vcf/merged/Uppsala_realigned_50_families_header.vcf
export CMM_SCILIFE_ILLUMINA_SEQUENCE_ROOT_DIR=$CMM_MASTER_DATA_ROOT_DIR/CMM_Scilife_b2011158/
export CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_MANS_GZ=$CMM_SCILIFE_ILLUMINA_SEQUENCE_ROOT_DIR/systematic/mans/merged/scilife_illumina_mans.vcf.gz
export CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_MANS_HEADER=$CMM_SCILIFE_ILLUMINA_SEQUENCE_ROOT_DIR/systematic/mans/merged/scilife_illumina_mans_header.vcf
export CMM_SCILIFE_ILLUMINA_ALL_PATIENTS_UPPSALA_GZ=$CMM_SCILIFE_ILLUMINA_SEQUENCE_ROOT_DIR/systematic/uppsala/merged/scilife_illumina_uppsala.vcf.gz
export CMM_AXEQ_SEQUENCE_ROOT_DIR=$CMM_MASTER_DATA_ROOT_DIR/CMM_Axeq_b2012247/
export CMM_AXEQ_CHR9_ALL_PATIENTS_GZ=$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr9/merged/Axeq_chr9.vcf.gz
export CMM_AXEQ_CHR9_ALL_PATIENTS_HEADER=$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr9/merged/Axeq_chr9_header.vcf
export CMM_AXEQ_CHR9_FOLDER=$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr9/vcf/
export CMM_AXEQ_CHR5_19_FOLDER=$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr5_19/vcf/
export CMM_AXEQ_CHR3_6_14_18_FOLDER=$CMM_AXEQ_SEQUENCE_ROOT_DIR/systematic/chr3_6_14_18/vcf/


##********************************************* tools/scripts location *****************************************************
#set active hbvdb location
export HBVDB_TOOLS_ROOT_DIR=$HOME_GLOB/tools/hbvdb
export HBVDB_BVD_GET=$HBVDB_TOOLS_ROOT_DIR/bin/bvd-get.pl
export HBVDB_BVD_ADD=$HBVDB_TOOLS_ROOT_DIR/bin/bvd-add.pl

#set third-party tools location
export TOOLS_ROOT_DIR=$HOME/development/third_party_tools
#ANNOVAR
export ANNOVAR_ROOT_DIR=$TOOLS_ROOT_DIR/annovar
export ANNOVAR_HUMAN_DB_DIR=$ANNOVAR_ROOT_DIR/humandb
export CONVERT2ANNOVAR=$ANNOVAR_ROOT_DIR/convert2annovar.pl
export SUMMARIZE_ANNOVAR=$ANNOVAR_ROOT_DIR/summarize_annovar.pl
##********************************************* tools/scripts location *****************************************************
