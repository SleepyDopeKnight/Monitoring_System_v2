#!/bin/bash

if [[ $# == 0 ]]; then
    sudo chmod +x ./log_generator.sh
    . ./log_generator.sh
else
    echo "Wrong input parameters"
    exit 1
fi

generate