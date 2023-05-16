#!/bin/bash

if [[ $# == 0 ]]; then
    sudo chmod +x ./collector.sh
    . ./collector.sh
else
    echo "Wrong input parameters"
    exit 1
fi

collect