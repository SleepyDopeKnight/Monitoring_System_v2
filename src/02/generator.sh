#!/bin/bash

log="log.txt"
sudo touch $log

function generate {
    date="$(date +"%d%m%y")"
    file_name=$(echo $p5 | awk -F. '{print $1}')
    file_extension=$(echo $p5 | awk -F. '{print $2}')
    folders=$p1
    file_name=$(echo $p2 | awk -F. '{print $1}')
    file_extension=$(echo $p2 | awk -F. '{print $2}')
    new_file_name=${file_name: -1}
    new_folders_name=${p1: -1}
    count_of_folders="$(shuf -i 1-100 -n1)"
    count_for_cycle="$(shuf -i 1-100 -n1)"
    count=1

    if [[ ${#folders} -lt 5 ]]; then
        for (( k=${#folders}; k<5; k++)); do
            folders+="$(echo $new_folders_name)"
        done
    fi

    if [[ ${#file_name} -lt 5 ]]; then
        for (( k=${#file_name}; k<5; k++)); do
            file_name+="$(echo $new_file_name)"
        done
    fi

    for (( i=1; i<=$count_for_cycle; i++)); do
        folder_generator="$(compgen -d / | shuf -n1 )"
        count_of_files="$(shuf -i 1-50 -n1)"
        if [[ $folder_generator == '/bin' || $folder_generator == '/sbin' ]]; then
            count_for_cyclet=$(($count_for_cycle + 1))
            continue
        fi
        sudo mkdir -p "$folder_generator"/"$folders"_"$date"
        for (( j=1; j<=$count_of_files; j++)); do
            echo "Создано $i/${count_for_cycle} директорий и создано $j/${count_of_files} файлов"
            free_space=$(df -h / -BM | grep '/' | awk -F"M" {'print $3'})
            if [[ $free_space -le 1024 ]]; then
                echo "1GB of memory left on the drive"
                exit 1
            fi
            sudo fallocate -l $file_size "$folder_generator"/"$folders"_"$date"/"$file_name"_"$date"."$file_extension"
            echo "Path: "$folder_generator"/"$folders"_"$date"/"$file_name"_"$date"."$file_extension" | Date of create: "$(date +"%d.%m.%y")" | File size: $file_size" | sudo tee -a $log
            file_name+="$(echo $new_file_name)"
            while [ $count -eq $count_of_files ]; do
                file_name=${file_name:0:5}
                count=0
            done
            count=$(($count + 1))
        done
        folders+="$(echo $new_folders_name)"
    done
}