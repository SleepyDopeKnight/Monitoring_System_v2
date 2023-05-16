#!/bin/bash

function generate {
    start_date="$(date "+%Y-%m-%d") 00:00:00 $(date +%z)"
    add_seconds=$(shuf -i 10-60 -n1)

    for (( i=1; i<6; i++)); do
        random_for_str=$(shuf -i 100-1000 -n1)
        for (( j=0; j<=$random_for_str; j++ )); do
            ip="$(shuf -i 1-255 -n1).$(shuf -i 1-255 -n1).$(shuf -i 1-255 -n1).$(shuf -i 1-255 -n1)"
            date="$(date -d "$start_date + $add_seconds seconds" +'%d/%b/%Y:%H:%M:%S %z')"
            date_for_log_name="$(date -d "$start_date + $add_seconds seconds" +'%d_%m_%Y')"
            methods=$(shuf methods.txt -n1)
            url_requests=$(shuf url_requests.txt -n1)
            protocols=$(shuf protocols.txt -n1)
            answer_codes=$(shuf answer_codes.txt -n1)
            agents=$(shuf agents.txt -n1)
            str="$ip - - ["$date"] \""$methods" "$url_requests" "$protocols"\" "$answer_codes" - \""$agents"\""
            log_name="log_$date_for_log_name.log"
            echo $str >> $log_name
            ((add_seconds+=$(shuf -i 10-60 -n1) ))
        done
        start_date="$(date -d "$start_date + $i days" +'%Y-%m-%d')"
    done
}

# 200 - OK — успешный запрос
# 201 - Created — Создан новый ресурс
# 400 - Bad Request — Плохой запрос
# 401 - Unauthorized — Требуется аутентификация
# 403 - Forbidden — Ограничение в доступе
# 404 - Not Found —  Не найден
# 500 - Internal Server Error — Внутренняя ошибка сервера
# 501 - Not Implemented — Не выполненно
# 502 - Bad Gateway — Плохой шлюз
# 503 - Service Unavailable — Сервис недоступен