#!/bin/bash

##############################################################################################
# Script created by helops.io to get the Terraform Apply order from a config.yaml file
#
# It reads and parse a YAML file and returns the apply_order array as an output in order
# to iterate over it and apply the Terraform modules in the correct order
##############################################################################################

yaml_file="config.yaml"

#--------------------------------------------
# Functions
#--------------------------------------------

check_dependencies() {
    local dependencies=("$@")
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "$dep could not be found. Please install $dep."
            exit 1
        fi
    done
}

check_files() {
    local files=("$@")
    for file in "${files[@]}"; do
        if [ ! -f "$file" ]; then
            echo "The file $file does not exist."
            exit 1
        fi
    done
}

check_dependencies yq
check_files $yaml_file

# Read the apply_order and output each item
yq e '.apply_order[]' "$yaml_file"
