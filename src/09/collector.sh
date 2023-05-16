#!/bin/bash

page_html="/var/files/report.html"
sudo touch $page_html
sudo chmod 777 $page_html

function collect {
    cpu="$(cat /proc/loadavg | awk '{print $1}')"
    available_memory="$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')"
    free_memory="$(cat /proc/meminfo | grep MemFree | awk '{print $2}')"
    total_memory="$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')"
    used_disk="$(df / | sed -n 2p | awk '{print $3}')"
    available_disk="$(df / | sed -n 2p | awk '{print $4}')"
    echo "# HELP cpu_usage Get CPU usage"
    echo "# TYPE cpu_usage gauge"
    echo "cpu_usage $cpu"
    echo "# HELP mem_total Get total mem"
    echo "# TYPE mem_total gauge"
    echo "mem_total $total_memory"
    echo "# HELP mem_free Get free mem"
    echo "# TYPE mem_free gauge"
    echo "mem_free $free_memory"
    echo "# HELP mem_available Get mem available"
    echo "# TYPE mem_available gauge"
    echo "mem_available $available_memory"
    echo "# HELP disk_used Get disk used"
    echo "# TYPE disk_used gauge"
    echo "disk_used $used_disk"
    echo "# HELP disk_available Get disk available"
    echo "# TYPE disk_available gauge"
    echo "disk_available $available_disk"
}

while true; do
    collect | tee $page_html
    sudo cp $page_html /var/files/metrics
    sleep 3
done
