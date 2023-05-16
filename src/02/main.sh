#!/bin/bash

count_start_script=$(date +%s%N)
start_script=$(date +%H:%M)

if [[ $# == 3 ]]; then
    export p1=$1
    export p2=$2
    export p3=$3

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

count_end_script=$(date +%s%N)
end_script=$(date +%H:%M)
count_worktime_script=$((($count_end_script - $count_start_script)/1000000))
echo "Начало работы скрипта: $start_script | Время окончания работы скрипта: $end_script | Общее время работы скрипта: $count_worktime_scriptмс" | sudo tee -a log.txt