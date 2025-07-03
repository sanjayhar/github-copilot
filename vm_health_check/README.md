# VM Health Check Script

`vm_health_check.sh` is a lightweight shell script designed for Amazon Linux (EC2) instances to quickly assess the health of a virtual machine (VM) based on CPU, memory, and disk space utilization.

## Features

- **Health Check Logic:**  
  - Reports the VM as **Healthy** if all three resources (CPU, memory, disk) are utilized at **60% or less**.
  - Reports the VM as **Not healthy** if any resource exceeds **60% usage**.

- **Explain Mode:**  
  - When run with the `explain` argument, the script provides a detailed explanation of each resource's usage and the reason for the health status.

- **Amazon Linux Compatible:**  
  - Designed for use on Amazon Linux EC2 instances (user: `ec2-user`).

## Usage

```sh
chmod +x vm_health_check.sh
./vm_health_check.sh            # Check VM health status
./vm_health_check.sh explain    # Check VM health and get detailed explanation
```

### Example Output

**Healthy Run:**
```
VM Health: Healthy
```

**Not healthy with explanation:**
```
VM Health: Not healthy
Explanation:
  - CPU usage is high: 75.12% (threshold: 60%)
  One or more resources are above 60% utilization.
```

**Healthy with explanation:**
```
VM Health: Healthy
Explanation:
  All resource utilizations are below or equal to 60%.
    CPU Usage: 25.00%
    Memory Usage: 40.00%
    Disk Usage: 33.00%
```

## What Does It Check?

- **CPU Usage:**  
  Uses `top` to calculate total CPU used (user + system).

- **Memory Usage:**  
  Uses `free` to calculate percentage of memory used.

- **Disk Usage:**  
  Uses `df` to calculate root (`/`) partition disk usage.

## Requirements

- Amazon Linux EC2 instance
- Bash shell (`/bin/bash`)
- Utilities: `top`, `awk`, `free`, `df`, `bc`, `sed`

*All required utilities are available by default on Amazon Linux.*

## Customization

- To change the threshold, modify the `threshold` value in the script.

## License

MIT License

---

*This script is provided as-is. Always test in a development environment before deploying to production.*
