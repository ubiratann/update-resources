#!/bin/bash

function set_vars(){
    local namespace="$1"
    source $namespace/resource_vars
}

function unset_vars(){
    unset CPU_LIMITS
    unset CPU_REQUESTS
    unset MEMORY_LIMITS
    unset MEMORY_REQUESTS
}

function update_resources(){
    local deployment_config="$1"
    local namespace="$2"
    oc set resources dc/$deployment_config -n $namespace --limits=cpu=$CPU_LIMITS,memory=$MEMORY_LIMITS --requests=cpu=$CPU_REQUESTS,memory=$MEMORY_REQUESTS
}

function main(){


    local read_file=$1
    while IFS= read -r line || [ -n "$line" ]
    do
        target_dc=$(echo $line |  awk -F  ":" '{print $1}')
        source_namespace=$(echo $line |  awk -F  ":" '{print $2}')
        target_namespace=$(echo $line |  awk -F  ":" '{print $3}')

        set_vars "$source_namespace"
        update_resources "$target_dc" "$target_namespace"
        unset_vars

    done < "$read_file"
}

main "$1"