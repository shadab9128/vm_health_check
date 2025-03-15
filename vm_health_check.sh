#!/bin/bash

# Function to check CPU utilization (Linux compatible)
check_cpu() {
    cpu_util=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "CPU Utilization: $cpu_util%"
    if (( $(echo "$cpu_util < 60" | bc -l) )); then
        return 0
    else
        return 1
    fi
}

# Function to check memory utilization (Linux compatible)
check_memory() {
    memory_util=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "Memory Utilization: $memory_util%"
    if (( $(echo "$memory_util < 60" | bc -l) )); then
        return 0
    else
        return 1
    fi
}

# Function to check disk space utilization (Linux compatible)
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