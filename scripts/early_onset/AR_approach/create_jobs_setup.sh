#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="Young"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/early_onset/AR/"
project_code="b2012247"
annotated_vcf_tabix="$ANNOTATED_WES294"
sample_infos="$script_dir/sample.info"
#coloring_zygosity="True"
anno_cols="Func.refGene"
anno_cols+=",ExonicFunc.refGene"
anno_cols+=",Gene.refGene"
anno_cols+=",GeneDetail.refGene"
anno_cols+=",snp138"
anno_cols+=",OAF_EARLYONSET_AF"
anno_cols+=",OAF_EARLYONSET_GF"
anno_cols+=",KVOT_EARLYONSET_VS_SWEGEN_ESTIMATED"
anno_cols+=",SWEGEN_AF"
anno_cols+=",SWEGEN_GF"
anno_cols+=",KVOT_EARLYONSET_VS_EXAC_NFE_ESTIMATED"
anno_cols+=",ExAC_NFE"
anno_cols+=",ExAC_ALL"
anno_cols+=",KVOT_EARLYONSET_VS_BRC_ESTIMATED"
anno_cols+=",OAF_BRCS_AF"
anno_cols+=",OAF_BRCS_GF"
anno_cols+=",OAF_CRCS_AF"
anno_cols+=",OAF_CRCS_GF"
anno_cols+=",1000g2014oct_eur"
anno_cols+=",1000g2014oct_all"
anno_cols+=",OAF_BRC_CRC_PROSTATE_AF"
anno_cols+=",OAF_BRC_CRC_PROSTATE_GF"
anno_cols+=",249_SWEDES"
anno_cols+=",200_DANES"
anno_cols+=",AAChange.refGene"
anno_cols+=",cytoBand"
anno_cols+=",Pathogenic_count"
anno_cols+=",SIFT_pred"
anno_cols+=",Polyphen2_HDIV_pred"
anno_cols+=",Polyphen2_HVAR_pred"
anno_cols+=",LRT_pred"
anno_cols+=",MutationTaster_pred"
anno_cols+=",MutationAssessor_pred"
anno_cols+=",FATHMM_pred"
anno_cols+=",RadialSVM_pred"
anno_cols+=",LR_pred"
anno_cols+=",CADD_phred"
report_regions="20"
#report_regions="19:58151338-58907700"
#report_regions+=",17:17009561-17069561"
filter_actions="Rare"
filter_actions+=",PASS-VQSR"
#filter_actions="PASS-VQSR"
filter_actions+=",Non-Intergenic"
filter_actions+=",Non-Intronic"
filter_actions+=",Non-Upstream"
filter_actions+=",Non-Downstream"
filter_actions+=",Non-Synonymous"
filter_actions+=",Non-UTR"
filter_actions+=",Non-Recessive-Gene"
freq_ratios="SWEGEN_AF:0.1"
expression_patterns="'Func_ncRNA_exonic:(\"Func.refGene\"=='\''ncRNA_exonic'\'')'"
expression_usages="Func_ncRNA_exonic:DELETE_ROW"
expression_patterns+=",'Func_ncRNA_splicing:(\"Func.refGene\"=='\''ncRNA_splicing'\'')'"
expression_usages+=",Func_ncRNA_splicing:DELETE_ROW"
expression_patterns+=",'ExonicFunc_unknown:(\"ExonicFunc.refGene\"=='\''unknown'\'')'"
expression_usages+=",ExonicFunc_unknown:DELETE_ROW"
expression_patterns+=",'EARLYONSET_0:(\"OAF_EARLYONSET_AF\"=='\''0.0000'\'')'"
expression_usages+=",EARLYONSET_0:DELETE_ROW"
expression_patterns+=",'EARLYONSET_1:(\"OAF_EARLYONSET_AF\"=='\''1.0000'\'')'"
expression_usages+=",EARLYONSET_1:DELETE_ROW"
expression_patterns+=",'EARLYONSET_NA:(\"OAF_EARLYONSET_AF\"=='\''NA'\'')'"
expression_usages+=",EARLYONSET_NA:DELETE_ROW"
expression_patterns+=",'EARLYONSET_dot:(\"OAF_EARLYONSET_AF\"=='\''.'\'')'"
expression_usages+=",EARLYONSET_dot:DELETE_ROW"
expression_patterns+=",'EARLYONSET_empty:(\"OAF_EARLYONSET_AF\"=='\'''\'')'"
expression_usages+=",EARLYONSET_empty:DELETE_ROW"
expression_patterns+=",'Pathogenic5:int(\"Pathogenic_count\")<5'"
expression_usages+=",Pathogenic5:DELETE_ROW"
expression_patterns+=",'EARLYONSET_lowQC:(float(\"OAF_EARLYONSET_GF\")<0.5)'"
expression_usages+=",EARLYONSET_lowQC:DELETE_ROW"
expression_patterns+=",'KVOT_BRC_13:(\"KVOT_EARLYONSET_VS_BRC_ESTIMATED\"!='\'''\'')and"
expression_patterns+="(\"KVOT_EARLYONSET_VS_BRC_ESTIMATED\"!='\''INF'\'')and"
expression_patterns+="(\"KVOT_EARLYONSET_VS_BRC_ESTIMATED\"!='\''NA'\'')and"
expression_patterns+="(float(\"KVOT_EARLYONSET_VS_BRC_ESTIMATED\")<1.3)'"
expression_usages+=",KVOT_BRC_13:DELETE_ROW"
expression_patterns+=",'KVOT_SWEGEN_13:(\"KVOT_EARLYONSET_VS_SWEGEN_ESTIMATED\"!='\'''\'')and"
expression_patterns+="(\"KVOT_EARLYONSET_VS_SWEGEN_ESTIMATED\"!='\''INF'\'')and"
expression_patterns+="(\"KVOT_EARLYONSET_VS_SWEGEN_ESTIMATED\"!='\''NA'\'')and"
expression_patterns+="(float(\"KVOT_EARLYONSET_VS_SWEGEN_ESTIMATED\")<1.3)'"
expression_usages+=",KVOT_SWEGEN_13:DELETE_ROW"
expression_patterns+=",'KVOT_EXAC_NFE_13:(\"KVOT_EARLYONSET_VS_EXAC_NFE_ESTIMATED\"!='\'''\'')and"
expression_patterns+="(\"KVOT_EARLYONSET_VS_EXAC_NFE_ESTIMATED\"!='\''INF'\'')and"
expression_patterns+="(\"KVOT_EARLYONSET_VS_EXAC_NFE_ESTIMATED\"!='\''NA'\'')and"
expression_patterns+="(float(\"KVOT_EARLYONSET_VS_EXAC_NFE_ESTIMATED\")<1.3)'"
expression_usages+=",KVOT_EXAC_NFE_13:DELETE_ROW"

jobs_setup_file="$dataset_name"_jobs_setup.txt

cmd="pyCMM-mutrep-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $anno_cols ]
then
    cmd+=" -a $anno_cols"
fi
if [ ! -z $anno_excl_tags ]
then
    cmd+=" -E $anno_excl_tags"
fi
if [ ! -z "$filter_actions" ]
then
    cmd+=" --filter_actions $filter_actions"
fi
if [ ! -z $filter_genes ]
then
    cmd+=" --filter_genes $filter_genes"
fi
if [ ! -z $color_genes ]
then
    cmd+=" --color_genes $color_genes"
fi
if [ ! -z "$expression_patterns" ]
then
    cmd+=" --expression_patterns $expression_patterns"
fi
if [ ! -z "$expression_usages" ]
then
    cmd+=" --expression_usages $expression_usages"
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
if [ "$summary_families" = "True" ]
then
    cmd+=" --summary_families"
fi
if [ "$coloring_zygosity" = "True" ]
then
    cmd+=" --coloring_zygosity"
fi
if [ "$show_shared_variants" == "True" ]
then
    cmd+=" --show_shared_variants"
fi
cmd+=" -o $jobs_setup_file"

eval "$cmd"
