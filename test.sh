#!/bin/bash


for file in teste/*/; do
    echo $file #| awk -F "/" '{print $2}'
done