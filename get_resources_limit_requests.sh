#!/bin/bash


function get_resource_limits(){
    local dc="$1"
    cpu_limits=$(oc get dc/${dc} -o jsonpath='{.spec.strategy.resources.limits.cpu}')
    echo "export CPU_LIMITS=${cpu_limits}" > resource_vars
    memory_limits=$(oc get dc/${dc} -o jsonpath='{.spec.strategy.resources.limits.memory}')
    echo "export MEMORY_LIMITS=${memory_limits}" >> resource_vars
}

function get_resource_requests(){
    local dc=$1
    cpu_requests=$(oc get dc/${dc} -o jsonpath='{.spec.strategy.resources.requests.cpu}')
    echo "export CPU_REQUESTS=${cpu_requests}" >> resource_vars
    memory_requests=$(oc get dc/${dc} -o jsonpath='{.spec.strategy.resources.requests.memory}')
    echo "export MEMORY_REQUESTS=${memory_requests}" >> resource_vars
}

function main(){
    get_resource_limits "$1"
    get_resource_requests "$1"
}

main "$1"