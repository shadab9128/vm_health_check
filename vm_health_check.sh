#!/bin/bash

# Function to check CPU utilization (macOS compatible)
check_cpu() {
    cpu_util=$(ps -A -o %cpu | awk '{s+=$1} END {print s}')
    echo "CPU Utilization: $cpu_util%"
    if (( $(echo "$cpu_util < 60" | bc -l) )); then
        return 0
    else
        return 1
    fi
}

# Function to check memory utilization (macOS compatible)
check_memory() {
    memory_total=$(sysctl -n hw.memsize)
    memory_used=$(vm_stat | grep "Pages active:" | awk '{print $3}' | tr -d '.')
    memory_util=$(echo "scale=2; ($memory_used * 4096 * 100) / $memory_total" | bc)
    echo "Memory Utilization: $memory_util%"
    if (( $(echo "$memory_util < 60" | bc -l) )); then
        return 0
    else
        return 1
    fi
}

# Function to check disk space utilization (macOS compatible)
check_disk() {
    disk_util=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "Disk Utilization: $disk_util%"
    if (( $(echo "$disk_util < 60" | bc -l) )); then
        return 0
    else
        return 1
    fi
}

# Main script logic
echo "Analyzing VM health..."

check_cpu
cpu_healthy=$?

check_memory
memory_healthy=$?

check_disk
disk_healthy=$?

if [ $cpu_healthy -eq 0 ] && [ $memory_healthy -eq 0 ] && [ $disk_healthy -eq 0 ]; then
    echo "VM State: Healthy"
else
    echo "VM State: Not Healthy"
fi