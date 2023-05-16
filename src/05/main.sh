#!/bin/bash

if [[ $# == 1 ]]; then
    export p1=$1

    sudo chmod +x ./analysator.sh
    . ./analysator.sh
else
    echo "Wrong input parameters"
    exit 1
fi

analyse