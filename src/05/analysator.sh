#!/bin/bash

function analyse {
    if [[ "$p1" -eq "1" ]]; then
        if [[  ! -f sorted_by_answer_codes.txt ]]; then
            cat ../04/log_*.txt >> all_logs.txt
            sort -k 9 all_logs.txt >> sorted_by_answer_codes.txt
            rm all_logs.txt
            echo "Logs sorted by answer codes"
        else
            echo "sorted_by_answer_codes.txt already exist"
        fi
    elif [[ "$p1" -eq "2" ]]; then
        if [[  ! -f unique_ip.txt ]]; then
            cat ../04/log_*.txt >> all_logs.txt
            awk '{print $1}' all_logs.txt | uniq >> unique_ip.txt
            rm all_logs.txt
            echo "Writed all uniques ip from logs"
        else
            echo "unique_ip.txt already exist"
        fi
    elif [[ "$p1" -eq "3" ]];then
        if [[  ! -f error_codes.txt ]]; then
            cat ../04/log_*.txt >> all_logs.txt
            awk '$9 ~ /[45]/' all_logs.txt >> error_codes.txt
            rm all_logs.txt
            echo "Writed all requests with errors"
        else
            echo "error_codes.txt already exist"
        fi
    elif [[ "$p1" -eq "4" ]]; then
        if [[  ! -f unique_ip_with_error.txt ]]; then
            cat ../04/log_*.txt >> all_logs.txt
            awk '$9 ~ /[45]/' all_logs.txt | awk '{print $1}' | uniq >> unique_ip_with_error.txt
            echo "Writed all uniques ip with errors from logs"
        else
            echo "unique_ip_with_error.txt already exist"
        fi
    else
        echo "Incorrect parameter input"
    fi
}