#!/bin/bash

source requests
source limits

function main(){
    local target=$1
    oc set resources dc/$target --limits=cpu=$CPU_LIMIT,memory=$MEMORY_LIMIT --requests=cpu=$CPU_REQUESTS,memory=$MEMORY_REQUESTS
}

main $1