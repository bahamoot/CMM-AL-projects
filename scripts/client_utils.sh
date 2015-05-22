#!/bin/bash

function create_directory_structure () {
    project_root_dir=$1
    if [ ! -d "$project_root_dir" ]; then
        mkdir "$project_root_dir"
    fi
    
    log_dir="$project_root_dir/log"
    if [ ! -d "$log_dir" ]; then
        mkdir "$log_dir"
    fi
    
    tmp_dir="$project_root_dir/tmp"
    if [ ! -d "$tmp_dir" ]; then
        mkdir "$tmp_dir"
    fi
    
    out_dir="$project_root_dir/out"
    if [ ! -d "$out_dir" ]; then
        mkdir "$out_dir"
    fi
}

