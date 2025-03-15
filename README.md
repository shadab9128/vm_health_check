How to Use
Step 1: Download the Script
Save the script to a file named vm_health_check.sh:



`nano vm_health_check.sh`

Copy and paste the script content into the file, then save and exit.

Step 2: Make the Script Executable
Run the following command to make the script executable:


`chmod +x vm_health_check.sh`
Step 3: Run the Script
Execute the script using:


``'
./vm_health_check.sh
```
Example Output

Analyzing VM health...
CPU Utilization: 12.3%
Memory Utilization: 45.6%
Disk Utilization: 33%
VM State: Healthy
Script Logic
CPU Utilization:

Uses the top -bn1 command to calculate CPU usage.

Memory Utilization:

Uses the free command to calculate memory usage.

Disk Utilization:

Uses the df command to calculate disk usage.

Health Check:

If all three metrics (CPU, Memory, Disk) are below 60%, the VM is declared Healthy.

If any metric exceeds 60%, the VM is declared Not Healthy.

Customization
You can modify the threshold (currently set to 60%) by editing the script and changing the value in the following lines:

```

if (( $(echo "$cpu_util < 60" | bc -l) )); then
if (( $(echo "$memory_util < 60" | bc -l) )); then
if (( $(echo "$disk_util < 60" | bc -l) )); then
```
Troubleshooting
bc Command Not Found:

Install bc using:


```
sudo apt install bc
```
Script Not Executable:

Ensure the script has execute permissions:


```
chmod +x vm_health_check.sh
```
Incorrect Output:

Verify that the script is running on an Ubuntu system. It is not compatible with macOS or Windows.