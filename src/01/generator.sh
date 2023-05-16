#!/bin/bash

log="log.txt"
sudo touch $log

function generate {
    count=1
    new_folders_name=${p3: -1}
    folders=$p3
    file_name=$(echo $p5 | awk -F. '{print $1}')
    new_file_name=${file_name: -1}
    file_extension=$(echo $p5 | awk -F. '{print $2}')
    date="$(date +"%d%m%y")"

    if [[ ${#folders} -lt 4 ]]; then
        for (( k=${#folders}; k<4; k++)); do
            folders+="$(echo $new_folders_name)"
        done
    fi

    if [[ ${#file_name} -lt 4 ]]; then
        for (( k=${#file_name}; k<4; k++)); do
            file_name+="$(echo $new_file_name)"
        done
    fi

    for (( i=1; i<=$p2; i++ )); do
        sudo mkdir -p "$p1"/"$folders"_"$date"
        for (( j=1; j<=$p4; j++ )); do
            sudo fallocate -l $file_size "$p1"/"$folders"_"$date"/"$file_name"_"$date"."$file_extension"
            free_space=$(df -h / -BM | grep '/' | awk -F"M" {'print $3'})
            if [[ $free_space -le 1024 ]]; then
                echo "1GB of memory left on the drive"
                exit 1
            fi
            echo "Path: "$p1"/"$folders"_"$date"/"$file_name"_"$date"."$file_extension" | Date of create: "$(date +"%d.%m.%y")" | File size: $file_size" | sudo tee -a $log
            file_name+="$(echo $new_file_name)"
            while [ $count -eq $p4 ]; do
                file_name=${file_name:0:4}
                count=0
            done
            count=$(($count + 1))
        done
        folders+="$(echo $new_folders_name)"
    done
}