#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dataset_name="Young_vs_FamCRCs"
project_out_dir="$MUTATIONS_REPORTS_OUTPUT_DIR/early_onset/AR/"
project_code="b2012247"
job_alloc_time="20:00:00"
db_file="$SQLITE_DB_GRCH37"
#annotated_vcf_tabix="$ANNOTATED_THYRCA"
sample_infos="$script_dir/young_vs_CRC_sample.info"
#coloring_zygosity="True"
call_detail="True"
anno_cols="Func.refGene"
anno_cols+=",ExonicFunc.refGene"
anno_cols+=",snp138"
anno_cols+=",Gene.refGene"
anno_cols+=",GeneDetail.refGene"
anno_cols+=",AAChange.refGene"
anno_cols+=",cytoBand"
anno_cols+=",MAX_REF_MAF"
anno_cols+=",SWEGEN_AF"
anno_cols+=",ExAC_ALL"
anno_cols+=",ExAC_NFE"
anno_cols+=",ExAC_AFR"
anno_cols+=",ExAC_AMR"
anno_cols+=",ExAC_EAS"
anno_cols+=",ExAC_FIN"
anno_cols+=",ExAC_SAS"
anno_cols+=",ExAC_OTH"
anno_cols+=",gnomAD_genome_ALL"
anno_cols+=",gnomAD_genome_AFR"
anno_cols+=",gnomAD_genome_AMR"
anno_cols+=",gnomAD_genome_ASJ"
anno_cols+=",gnomAD_genome_EAS"
anno_cols+=",gnomAD_genome_FIN"
anno_cols+=",gnomAD_genome_NFE"
anno_cols+=",gnomAD_genome_OTH"
anno_cols+=",249_SWEDES"
anno_cols+=",200_DANES"
anno_cols+=",1000g2014oct_all"
anno_cols+=",1000g2014oct_eur"
anno_cols+=",InterVar_class"
anno_cols+=",InterVar_evidence"
anno_cols+=",ExAC_nontcga_ALL"
anno_cols+=",ExAC_nontcga_NFE"
anno_cols+=",ExAC_nontcga_AFR"
anno_cols+=",ExAC_nontcga_AMR"
anno_cols+=",ExAC_nontcga_EAS"
anno_cols+=",ExAC_nontcga_FIN"
anno_cols+=",ExAC_nontcga_SAS"
anno_cols+=",ExAC_nontcga_OTH"
anno_cols+=",OAF_EARLYONSET_AF"
anno_cols+=",OAF_EARLYONSET_GF"
anno_cols+=",OAF_BRCS_AF"
anno_cols+=",OAF_BRCS_GF"
anno_cols+=",OAF_FAMILIAL_CRCS_AF"
anno_cols+=",OAF_FAMILIAL_CRCS_GF"
anno_cols+=",OAF_BRC_CRC_PROSTATE_AF"
anno_cols+=",OAF_BRC_CRC_PROSTATE_GF"
anno_cols+=",OAF_CHEK2_AF"
anno_cols+=",OAF_CHEK2_GF"
anno_cols+=",SWEGEN_HET"
anno_cols+=",SWEGEN_HOM"
anno_cols+=",SWEGEN_HEMI"
anno_cols+=",SWEGEN_AC"
anno_cols+=",SWEGEN_GT"
anno_cols+=",SWEGEN_GF"
anno_cols+=",SWEGEN_PF"
anno_cols+=",EXAC03_CONSTRAINT_EXP_SYN"
anno_cols+=",EXAC03_CONSTRAINT_N_SYN"
anno_cols+=",EXAC03_CONSTRAINT_SYN_Z"
anno_cols+=",EXAC03_CONSTRAINT_EXP_MIS"
anno_cols+=",EXAC03_CONSTRAINT_N_MIS"
anno_cols+=",EXAC03_CONSTRAINT_MIS_Z"
anno_cols+=",EXAC03_CONSTRAINT_EXP_LOF"
anno_cols+=",EXAC03_CONSTRAINT_N_LOF"
anno_cols+=",EXAC03_CONSTRAINT_PLI"
anno_cols+=",cosmic70"
anno_cols+=",CLINSIG"
anno_cols+=",CLNDBN"
anno_cols+=",CLNACC"
anno_cols+=",CLNDSDB"
anno_cols+=",CLNDSDBID"
anno_cols+=",clinvar_20150330"
anno_cols+=",dpsi_zscore"
anno_cols+=",Pathogenic_count"
anno_cols+=",SIFT_pred"
anno_cols+=",Polyphen2_HDIV_pred"
anno_cols+=",Polyphen2_HVAR_pred"
anno_cols+=",LRT_pred"
anno_cols+=",MutationTaster_pred"
anno_cols+=",MutationAssessor_pred"
anno_cols+=",FATHMM_pred"
anno_cols+=",MetaSVM_pred"
anno_cols+=",MetaLR_pred"
anno_cols+=",CADD_phred"
#anno_excl_tags="Mutstat_details"
#anno_excl_tags+=",ExAC_Other"
#anno_excl_tags+=",Unknown"
#filter_actions="Rare"
#filter_actions+=",PASS-VQSR"
##filter_actions="PASS-VQSR"
#filter_actions+=",Non-Intergenic"
filter_actions="Non-Intergenic"
filter_actions+=",Non-Intronic"
filter_actions+=",Non-Upstream"
filter_actions+=",Non-Downstream"
filter_actions+=",Non-UTR"
filter_actions+=",Non-Recessive-Gene"
#filter_actions+=",Has-Shared"
#filter_actions+=",Has-Mutation"
freq_ratios="SWEGEN_AF:0.1"
#report_regions="22"
#report_regions="8:144992269-145047573"
#color_genes="A1CF"
#color_genes+=",A2M"
#color_genes+=",A2ML1"
#color_genes+=",AACS"
#color_genes+=",AADACL2"
#color_genes+=",AASDH"
#color_genes+=",AASDHPPT"
#color_genes+=",ABAT"
#color_genes+=",ABCA1"
#color_genes+=",ABCA12"
#color_genes+=",ABCA2"
#color_genes+=",ABCA3"
#color_genes+=",ABCA4"
#color_genes+=",ABCA5"
expression_patterns="'Func_ncRNA_exonic:(\"Func.refGene\"=='\''ncRNA_exonic'\'')'"
expression_usages="Func_ncRNA_exonic:DELETE_ROW"
expression_patterns+=",'Func_ncRNA_intronic:(\"Func.refGene\"=='\''ncRNA_intronic'\'')'"
expression_usages+=",Func_ncRNA_intronic:DELETE_ROW"
expression_patterns+=",'Func_ncRNA_splicing:(\"Func.refGene\"=='\''ncRNA_splicing'\'')'"
expression_usages+=",Func_ncRNA_splicing:DELETE_ROW"
expression_patterns+=",'ExonicFunc_unknown:(\"ExonicFunc.refGene\"=='\''unknown'\'')'"
expression_usages+=",ExonicFunc_unknown:DELETE_ROW"
expression_patterns+=",'true_synonymous:(\"dpsi_zscore\"!='\'''\'')and"
expression_patterns+="(\"ExonicFunc.refGene\"=='\''synonymous_SNV'\'')and"
expression_patterns+="(float(\"dpsi_zscore\")<2)'"
expression_usages+=",true_synonymous:DELETE_ROW"
expression_patterns+=",'likely_synonymous:(\"dpsi_zscore\"=='\'''\'')and"
expression_patterns+="(\"ExonicFunc.refGene\"=='\''synonymous_SNV'\'')'"
expression_usages+=",likely_synonymous:DELETE_ROW"
expression_patterns+=",'MAX_REF_MAF_COMMON:(\"MAX_REF_MAF\"!='\'''\'')and"
expression_patterns+="(float(\"MAX_REF_MAF\")<=0.80)and"
expression_patterns+="(float(\"MAX_REF_MAF\")>=0.20)'"
expression_usages+=",MAX_REF_MAF_COMMON:DELETE_ROW"
expression_patterns+=",'Pathogenic5:int(\"Pathogenic_count\")<5'"
expression_usages+=",Pathogenic5:DELETE_ROW"
expression_patterns+=",'EARLYONSET_lowQC:(float(\"OAF_EARLYONSET_GF\")<0.5)'"
expression_usages+=",EARLYONSET_lowQC:DELETE_ROW"
expression_patterns+=",'MUTATED_REF:(\"SWEGEN_AF\"!='\'''\'')and"
expression_patterns+="(float(\"SWEGEN_AF\")>=0.50)'"
expression_usages+=",MUTATED_REF:DELETE_ROW"

jobs_setup_file="$dataset_name"_jobs_setup.txt

cmd="pyCMM-mutrepdb-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $job_alloc_time ]
then
    cmd+=" --job_alloc_time $job_alloc_time"
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
if [ ! -z $db_file ]
then
    cmd+=" -A $db_file"
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

dataset_name="Young_vs_FamBRCs"
sample_infos="$script_dir/young_vs_BRC_sample.info"
jobs_setup_file="$dataset_name"_jobs_setup.txt

cmd="pyCMM-mutrepdb-create-job-setup-file"
cmd+=" -d $dataset_name"
cmd+=" -O $project_out_dir"
if [ ! -z $project_code ]
then
    cmd+=" -p $project_code"
fi
if [ ! -z $job_alloc_time ]
then
    cmd+=" --job_alloc_time $job_alloc_time"
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
if [ ! -z $db_file ]
then
    cmd+=" -A $db_file"
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
