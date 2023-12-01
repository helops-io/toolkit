#!/usr/bin/env bats

setup() {
    # Create a config.yaml file before each test runs
    touch config.yaml
    load '../get_apply_order.sh'
}

teardown() {
    # Remove the config.yaml file after each test completes
    rm -f config.yaml
}

@test "Dependency check fails for non-existent dependency" {
    run check_dependencies "non_existent_dependency"
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "non_existent_dependency could not be found. Please install non_existent_dependency." ]
}

@test "File check fails for non-existent file" {
    run check_files "non_existent_file.yaml"
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "The file non_existent_file.yaml does not exist." ]
}