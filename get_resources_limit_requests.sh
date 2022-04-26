#!/bin/bash


function get_resource_limits(){
    local dc=$1
    cpu_limit=$(oc get dc/$dc -o jsonpath='{.spec.strategy.resources.limits.cpu}')
    echo "export CPU_LIMIT=${cpu_limit}" > limits
    memory_limit=$(oc get dc/$dc -o jsonpath='{.spec.strategy.resources.limits.memory}')
    echo "export MEMORY_LIMIT=$memory_limit" >> limits
}

function get_resorce_requests(){
    local dc=$1
    cpu_request=$(oc get dc/$dc -o jsonpath='{.spec.strategy.resources.requests.cpu}')
    echo "export CPU_REQUESTS=$cpu_requests" > requests
    memory_request=$(oc get dc/$dc -o jsonpath='{.spec.strategy.resources.requests.memory}')
    echo "export MEMORY_REQUESTS=$memory_request">> requests
}

function main(){
    get_resource_limits $1
    get_resorce_requests $1
}

main $1