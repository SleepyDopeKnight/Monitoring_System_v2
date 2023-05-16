#!/bin/bash

if [[ $# == 6 ]]; then
    export p1=$1
    export p2=$2
    export p3=$3
    export p4=$4
    export p5=$5
    export p6=$6

    sudo chmod +x ./generator.sh
    sudo chmod +x ./validator.sh
    . ./validator.sh
    . ./generator.sh
else
    echo "Wrong input parameters"
    exit 1
fi

check_input
generate