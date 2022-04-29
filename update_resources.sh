#!/bin/bash

set -e 

function set_vars(){
    local namespace="$1"
    local deployment_config="$2"
    source ${namespace}/${deployment_config}/resource_vars
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
        target_deployment_config=$(echo $line |  awk -F  ":" '{print $1}')
        source_namespace=$(echo $line |  awk -F  ":" '{print $2}')
        target_namespace=$(echo $line |  awk -F  ":" '{print $3}')

        echo -e "\nApplying $source_namespace -> $target_namespace"
        if [ "$target_deployment_config" == '*' ]; then
            for file in $source_namespace/*/; do
                tmp_deployment_config=$(echo $file  | awk -F "/" '{print $2}')
                echo "* Current deployment config: ${tmp_deployment_config}"
                set_vars "$source_namespace" "$tmp_deployment_config"
                update_resources "$tmp_deployment_config" "$target_namespace"
                unset_vars
            done
        else
            echo "* Current deployment config: ${target_deployment_config}"
            set_vars "$source_namespace" "$target_deployment_config"
            update_resources "$target_deployment_config" "$target_namespace"
            unset_vars
        fi

    done < "$read_file"
}

main "$1"