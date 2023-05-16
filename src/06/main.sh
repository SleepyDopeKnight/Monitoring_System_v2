#!/bin/bash

if [[ $# == 0 ]]; then
    if [[ ! -f index.html ]]; then
        sudo goaccess ../04/*.log --log-format=COMBINED -a -o index.html
    else
        echo "index.html already exist"
    fi
else
    echo "Wrong input parameters"
    exit 1
fi