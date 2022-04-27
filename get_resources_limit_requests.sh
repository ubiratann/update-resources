#!/bin/bash


function get_resource_limits(){
    local deployment_config="$1"
    local namespace="$2"

    cpu_limits=$(oc get dc/$deployment_config -n $namespace -o jsonpath='{.spec.strategy.resources.limits.cpu}')
    echo "export CPU_LIMITS=${cpu_limits}" > ./${namespace}/${deployment_config}/resource_vars
    memory_limits=$(oc get dc/$deployment_config -n $namespace -o jsonpath='{.spec.strategy.resources.limits.memory}')
    echo "export MEMORY_LIMITS=${memory_limits}" >> ./${namespace}/${deployment_config}/resource_vars
}

function get_resource_requests(){
    local deployment_config=$1
    local namespace="$2"

    cpu_requests=$(oc get dc/$deployment_config -n $namespace -o jsonpath='{.spec.strategy.resources.requests.cpu}')
    echo "export CPU_REQUESTS=${cpu_requests}" >> ./${namespace}/${deployment_config}/resource_vars
    memory_requests=$(oc get dc/$deployment_config -n $namespace -o jsonpath='{.spec.strategy.resources.requests.memory}')
    echo "export MEMORY_REQUESTS=${memory_requests}" >> ./${namespace}/${deployment_config}/resource_vars
}

function main(){

    local read_file=$1
    while IFS= read -r line || [ -n "$line" ]
    do
        deployment_config=$(echo $line |  awk -F  ":" '{print $1}')
        namespace=$(echo $line |  awk -F  ":" '{print $2}')

        mkdir -p $namespace/$deployment_config

        get_resource_limits $deployment_config $namespace
        get_resource_requests $deployment_config $namespace

    done < "$read_file"
}

main "$1"