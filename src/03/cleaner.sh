#!/bin/bash

user=$(whoami)

function clean {
    if [[ "$p1" -eq "1" ]]; then
        if [[ -f /home/$user/DO4_LinuxMonitoring_v2.0-0/src/02/log.txt ]]; then
            path_1="$(cat ../02/log.txt | awk -F':' '{print $2}' | awk -F'|' '{print $1}')"
            for i in $path_1; do
                sudo rm -rf $i
                echo "${i}"
            done
            sudo rm ../02/log.txt
            echo $path_1
            echo "System is cleared!"
        else
            echo "Log.txt does not exist"
        fi
    elif [[ "$p1" -eq "2" ]]; then        
        read -p "Enter the start date and time in format: YYYY-MM-DD HH:MM - " time_start
        read -p "Enter the end date and time in format: YYYY-MM-DD HH:MM - " time_end

        if [[ ! $time_start =~ [0-9]{4}-[0-9]{2}-[0-9]{2}\ [0-9]{2}:[0-9]{2} || ! $time_end =~ [0-9]{4}-[0-9]{2}-[0-9]{2}\ [0-9]{2}:[0-9]{2} ]]; then
            echo "Incorrect date/time input"
            exit 1
        fi

        path_2=$(sudo find / -regextype posix-extended -regex '^/(.*\/)*[a-zA-Z]+_[0-9]{6}' -newermt "$time_start" ! -newermt "$time_end" -type d)
        if [[ $path_2 != "" ]]; then
            echo $path_2
            sudo rm -rf $path_2
            echo "System cleared!"
        else
            echo "Nothing to delete"
        fi
    elif [[ "$p1" -eq "3" ]];then
        sudo chown -R $user /lost+found/
        sudo chown -R $user /root/
        name_mask=$(sudo find / -regextype posix-extended -regex '^/(.*\/)*[a-zA-Z]+_[0-9]{6}') 
        #regex for find folders and files
        help_name_mask=${name_mask: -8}
        if [[ $name_mask != "" ]]; then
            echo $name_mask
            remove
            echo "System cleared!"
        else
            echo "Nothing to delete"
        fi
    else
        echo "Incorrect parameter input"
    fi
}

function remove {
    cd /
    sudo rm -rf *$help_name_mask
    sudo rm -rf /*/*$help_name_mask
} 