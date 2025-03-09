```sh

#!/bin/bash


# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "Please run this script as root." 1>&2
   exit 1
fi

echo "Starting Linux system optimization..."

# --------------------------
# 1. Backup Current Configurations
# --------------------------
echo "Backing up current configurations..."
mkdir -p /backup/sysctl_config
cp /etc/sysctl.conf /backup/sysctl_config/sysctl.conf.bak
cp /etc/security/limits.conf /backup/sysctl_config/limits.conf.bak

# --------------------------
# 2. Kernel and Memory Optimization
# --------------------------
echo "Configuring memory management..."
cat <<EOF >> /etc/sysctl.conf
# Reduce swap usage
vm.swappiness=10
# Reduce delay in writing data to disk
vm.dirty_ratio=10
vm.dirty_background_ratio=5
# Optimize filesystem cache
vm.vfs_cache_pressure=50
# Enable HUGE PAGES for heavy processing
vm.nr_hugepages=128
EOF

# --------------------------
# 3. Process and Resource Optimization
# --------------------------
echo "Optimizing process handling..."
ulimit -n 1048576
ulimit -u 65536
cat <<EOF >> /etc/security/limits.conf
*         hard    nofile      1048576
*         soft    nofile      1048576
root      hard    nofile      1048576
root      soft    nofile      1048576
aress     hard    nofile      1048576
aress     soft    nofile      1048576
EOF

# --------------------------
# 4. Network and Internet Speed Optimization
# --------------------------
echo "Optimizing network settings..."
cat <<EOF >> /etc/sysctl.conf
# Enable BBR for TCP optimization
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
# Increase send/receive buffer size
net.core.rmem_max=16777216
net.core.wmem_max=16777216
net.ipv4.tcp_rmem=4096 87380 16777216
net.ipv4.tcp_wmem=4096 87380 16777216
EOF

# --------------------------
# 5. Free Memory and Clear Cache
# --------------------------
echo "Clearing memory cache..."
sync; echo 3 > /proc/sys/vm/drop_caches
sync; echo 1 > /proc/sys/vm/compact_memory


# --------------------------
# 7. Enable zRam for Improved Performance
# --------------------------
echo "Enabling zRam..."
modprobe zram
echo lz4 > /sys/block/zram0/comp_algorithm
echo 2G > /sys/block/zram0/disksize
mkswap /dev/zram0
swapon /dev/zram0 -p 10

# --------------------------
# 8. Disable Unnecessary Services
# --------------------------
echo "Disabling unnecessary services..."
for service in cups avahi-daemon bluetooth; do
    if systemctl is-active --quiet $service; then
        systemctl disable $service
        systemctl stop $service
        echo "Service $service disabled."
    else
        echo "Service $service is already disabled."
    fi
done

# --------------------------
# 9. Optimize CPU Governor
# --------------------------
echo "Setting CPU Governor to performance mode..."
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo performance > $cpu
done

# --------------------------
# 10. Apply and Save Settings
# --------------------------
echo "Applying and saving changes..."
sysctl -p

echo "Optimization complete! Please restart your system for changes to take effect."



exit 0
```
