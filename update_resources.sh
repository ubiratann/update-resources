#!/bin/bash

source resource_vars

function main(){
    local target="$1"
    oc set resources dc/$target --limits=cpu=$CPU_LIMITS,memory=$MEMORY_LIMITS --requests=cpu=$CPU_REQUESTS,memory=$MEMORY_REQUESTS
}

main "$1"