#!/bin/bash


function get_resource_limits(){
    local dc="$1"
    local namespace="$2"

    cpu_limits=$(oc get dc/$dc -n $namespace -o jsonpath='{.spec.strategy.resources.limits.cpu}')
    echo "export CPU_LIMITS=${cpu_limits}" > ./${namespace}/resource_vars
    memory_limits=$(oc get dc/$dc -n $namespace -o jsonpath='{.spec.strategy.resources.limits.memory}')
    echo "export MEMORY_LIMITS=${memory_limits}" >> ./${namespace}/resource_vars
}

function get_resource_requests(){
    local dc=$1
    local namespace="$2"

    cpu_requests=$(oc get dc/$dc -n $namespace -o jsonpath='{.spec.strategy.resources.requests.cpu}')
    echo "export CPU_REQUESTS=${cpu_requests}" >> ./${namespace}/resource_vars
    memory_requests=$(oc get dc/$dc -n $namespace -o jsonpath='{.spec.strategy.resources.requests.memory}')
    echo "export MEMORY_REQUESTS=${memory_requests}" >> ./${namespace}resource_vars
}

function main(){
    get_resource_limits "$1"
    get_resource_requests "$1"
}

main "$1"