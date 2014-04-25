project_name="sanna_colon_rectal"
sub_project_name="rectal_all_patients"
dataset_name="sv_rectal_all_patients"

if [ ! -d "$CMM_PROJECTS_OUTPUT_DIR/$project_name" ]; then
    mkdir "$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi
if [ ! -z "$sub_project_name" ]; then
    out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name/$sub_project_name"
    if [ ! -d "$out_dir" ]; then
        mkdir "$out_dir"
    fi
else
    out_dir="$CMM_PROJECTS_OUTPUT_DIR/$project_name"
fi


##********************************************* set parameters here *****************************************************
export DEFAULT_DATA_PROJECT_CODE="b2011117"
export DEFAULT_DATA_DATASET_NAME=$dataset_name
export DEFAULT_DATA_TABIX_FILE=$CMM_UPPSALA_58FAM_ALL_PATIENTS_GZ
export DEFAULT_DATA_HBVDB_TOOLS_ROOT_DIR=$HBVDB_TOOLS_ROOT_DIR
export DEFAULT_DATA_ANNOVAR_ROOT_DIR=$ANNOVAR_ROOT_DIR
export DEFAULT_DATA_WORKING_DIR=$CMM_PROJECTS_WORKING_DIR
export DEFAULT_DATA_LOG_DIR=$CMM_PROJECTS_LOG_DIR

export DEFAULT_DATA_OAF_OUT_FILE=$out_dir/$dataset_name.oaf
export DEFAULT_DATA_GT_VCF_GT_OUT_FILE=$out_dir/$dataset_name.gt.vgt
export DEFAULT_DATA_MT_VCF_GT_OUT_FILE=$out_dir/$dataset_name.mt.vgt
export DEFAULT_DATA_SA_OUT_FILE=$out_dir/$dataset_name.sa

# vcf region from ~#rs29132-rs12961009
export DEFAULT_DATA_VCF_REGION="18:9944959-21600000"
#col_names="Co35,Co37,Co238,Co367,Co446,Co555,Co572,Co1262,Co618,Co793,Co876,Co1116,Co851,Co859,Co846,Co857,Co1458,Co1595,Co1274,Co1207,Co1302,Co1322,Co1583,Co1584,Co1349,531-04o,Co1467,529-05,Co1373,602-05o,Co1383,134-06,354-06,Co1538,642-06,1052-05,Co1301"
##********************************************* set parameters here *****************************************************

$EXEC_SCRIPT_GEN_DEFAULT_DATA
