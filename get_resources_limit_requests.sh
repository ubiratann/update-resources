#!/bin/bash


function get_resource_limits(){
    local deployment_config="$1"
    local namespace="$2"

    cpu_limits=$(oc get dc/$deployment_config -n $namespace -o jsonpath='{.spec.temaplete.spec.containers[].resources.limits.cpu}')
    echo "export CPU_LIMITS=${cpu_limits}" > ./${namespace}/${deployment_config}/resource_vars
    
    memory_limits=$(oc get dc/$deployment_config -n $namespace -o jsonpath='{.spec.temaplete.spec.containers[].resources.limits.memory}')
    echo "export MEMORY_LIMITS=${memory_limits}" >> ./${namespace}/${deployment_config}/resource_vars
    
}

function get_resource_requests(){
    local deployment_config=$1
    local namespace="$2"

    cpu_requests=$(oc get dc/$deployment_config -n $namespace -o jsonpath='{.spec.temaplete.spec.containers[].resources.requests.cpu}')
    echo "export CPU_REQUESTS=${cpu_requests}" >> ./${namespace}/${deployment_config}/resource_vars
    
    memory_requests=$(oc get dc/$deployment_config -n $namespace -o jsonpath='{.spec.temaplete.spec.containers[].resources.requests.memory}')
    echo "export MEMORY_REQUESTS=${memory_requests}" >> ./${namespace}/${deployment_config}/resource_vars
}

function main(){

    local read_file=$1
    while IFS= read -r line || [ -n "$line" ]
    do
        deployment_config=$(echo $line |  awk -F  ":" '{print $1}')
        namespace=$(echo $line |  awk -F  ":" '{print $2}')

        echo "Getting deployments from ${namespace} "
        if [ "$deployment_config" == '*' ]; then
            mkdir -p  /tmp/$namespace/
            oc get dc -n $namespace --no-headers | awk '{print $1}' > /tmp/$namespace/deployment_configs
            while IFS= read -r tmp_deployment_config || [ -n "$tmp_deployment_config" ]
            do
                echo "* Current deployment ${tmp_deployment_config}"
                mkdir -p $namespace/$tmp_deployment_config
                get_resource_limits $tmp_deployment_config $namespace
                get_resource_requests $tmp_deployment_config $namespace
            done < /tmp/$namespace/deployment_configs
        else
            echo "* Current deployment ${deployment_config}"
            mkdir -p $namespace/$deployment_config
            get_resource_limits $deployment_config $namespace
            get_resource_requests $deployment_config $namespace
        fi

    done < "$read_file"
}

main "$1"