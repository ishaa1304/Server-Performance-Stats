#!/bin/bash

echo "========================================="
echo "       SERVER PERFORMANCE STATS"
echo "========================================="


echo ""
echo ">>> Total CPU Usage:"

cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d "%" -f 1)
cpu_usage=$(echo "scale=2; 100 - $cpu_idle" | bc)
echo "CPU Usage: $cpu_usage%"


echo ""
echo ">>> Total Memory Usage (Free vs Used):"
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_free=$(free -m | awk '/Mem:/ {print $4}')
mem_percent=$(echo "scale=2; $mem_used / $mem_total * 100" | bc)
echo "Total Memory: ${mem_total}MB"
echo "Used Memory: ${mem_used}MB"
echo "Free Memory: ${mem_free}MB"
echo "Memory Usage: $mem_percent%"


echo ""
echo ">>> Total Disk Usage (Free vs Used):"
disk_usage=$(df -h / | awk 'NR==2 {print $3 " used / " $2 " total (" $5 " used)"}')
echo "$disk_usage"

echo ""
echo ">>> Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6


echo ""
echo ">>> Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
echo ""
echo "========================================="
echo "           END OF STATS REPORT"
echo "========================================="
