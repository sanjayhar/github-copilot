#!/bin/bash

# vm_health_check.sh
# Analyzes the health of an Amazon Linux VM based on CPU, memory, and disk usage.
# Usage: ./vm_health_check.sh [explain]

# Function to get CPU utilization percentage (user + system)
get_cpu_usage() {
    # Use top in batch mode, get 1 sample, parse %id (idle)
    idle=$(top -bn1 | grep "Cpu(s)" | awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); for (i in vs) { if (vs[i] ~ /[0-9.]+/) print vs[i] } }')
    cpu_usage=$(echo "scale=2; 100 - $idle" | bc)
    echo "$cpu_usage"
}

# Function to get memory utilization percentage
get_mem_usage() {
    # free -m output: total, used, free, shared, buff/cache, available
    # Use "free" and calculate used/total
    read total used <<< $(free -m | awk '/^Mem:/ {print $2, $3}')
    mem_usage=$(echo "scale=2; ($used / $total) * 100" | bc)
    echo "$mem_usage"
}

# Function to get disk utilization percentage (root partition "/")
get_disk_usage() {
    # df output: Filesystem Size Used Avail Use% Mounted on
    disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "$disk_usage"
}

cpu_usage=$(get_cpu_usage)
mem_usage=$(get_mem_usage)
disk_usage=$(get_disk_usage)

explain=0
if [[ "$1" == "explain" ]]; then
    explain=1
fi

threshold=60
status="Healthy"

# Check if any metric is above the threshold
if (( $(echo "$cpu_usage > $threshold" | bc -l) )) || \
   (( $(echo "$mem_usage > $threshold" | bc -l) )) || \
   (( $(echo "$disk_usage > $threshold" | bc -l) )); then
    status="Not healthy"
fi

echo "VM Health: $status"

if [[ $explain -eq 1 ]]; then
    if [[ "$status" == "Healthy" ]]; then
        echo "Explanation:"
        echo "  All resource utilizations are below or equal to $threshold%."
        printf "    CPU Usage: %.2f%%\n" "$cpu_usage"
        printf "    Memory Usage: %.2f%%\n" "$mem_usage"
        printf "    Disk Usage: %.2f%%\n" "$disk_usage"
    else
        echo "Explanation:"
        [[ $(echo "$cpu_usage > $threshold" | bc -l) -eq 1 ]] && printf "  - CPU usage is high: %.2f%% (threshold: %d%%)\n" "$cpu_usage" "$threshold"
        [[ $(echo "$mem_usage > $threshold" | bc -l) -eq 1 ]] && printf "  - Memory usage is high: %.2f%% (threshold: %d%%)\n" "$mem_usage" "$threshold"
        [[ $(echo "$disk_usage > $threshold" | bc -l) -eq 1 ]] && printf "  - Disk usage is high: %.2f%% (threshold: %d%%)\n" "$disk_usage" "$threshold"
        echo "  One or more resources are above $threshold% utilization."
    fi
fi

exit 0
