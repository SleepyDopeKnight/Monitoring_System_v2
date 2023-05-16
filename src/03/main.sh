#!/bin/bash

if [[ $# == 1 ]]; then
    export p1=$1

    sudo chmod +x ./cleaner.sh
    . ./cleaner.sh
else
    echo "Wrong input parameters"
    exit 1
fi

clean