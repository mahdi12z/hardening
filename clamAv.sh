```sh
#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Please run this script as root."
   exit 1
fi

echo "Starting ClamAV installation and setup..."

# --------------------------
# Install ClamAV
# --------------------------
echo "Installing ClamAV..."

if command -v apt >/dev/null 2>&1; then
    apt update -y
    apt install -y clamav clamav-daemon
elif command -v yum >/dev/null 2>&1; then
    yum install -y epel-release
    yum install -y clamav clamav-update clamav-scanner clamav-server
elif command -v dnf >/dev/null 2>&1; then
    dnf install -y clamav clamav-update clamav-scanner clamav-server
else
    echo "Unsupported package manager. Install ClamAV manually."
    exit 1
fi

# --------------------------
# Update ClamAV Database
# --------------------------
echo "Updating ClamAV virus database..."
systemctl stop clamav-freshclam
freshclam
systemctl start clamav-freshclam

# --------------------------
# Configure ClamAV Daemon
# --------------------------
echo "Configuring ClamAV daemon..."
sed -i 's/^Example/#Example/' /etc/clamav/clamd.conf
sed -i 's/^Example/#Example/' /etc/clamav/freshclam.conf

# Add OnAccessExcludeUID to prevent scanning loops
CLAMAV_UID=$(id -u clamav)
echo "Adding OnAccessExcludeUID $CLAMAV_UID to /etc/clamav/clamd.conf"
echo "OnAccessExcludeUID $CLAMAV_UID" >> /etc/clamav/clamd.conf

# Ensure LocalSocket is correctly set
sed -i 's|^#LocalSocket .*|LocalSocket /var/run/clamav/clamd.ctl|' /etc/clamav/clamd.conf

systemctl enable clamav-daemon
systemctl restart clamav-daemon

# --------------------------
# Verify ClamAV Daemon Status
# --------------------------
echo "Checking ClamAV daemon status..."
systemctl status clamav-daemon --no-pager || {
    echo "ERROR: ClamAV daemon failed to start. Check logs with: journalctl -u clamav-daemon --no-pager"
    exit 1
}

# --------------------------
# Fix clamd socket issues
# --------------------------
echo "Ensuring clamd socket exists..."
if [ ! -S /var/run/clamav/clamd.ctl ]; then
    echo "ERROR: ClamAV socket file not found. Restarting ClamAV..."
    systemctl stop clamav-daemon
    rm -f /var/run/clamav/clamd.ctl /var/run/clamav/clamd.pid
    systemctl start clamav-daemon
    sleep 5
fi

if [ ! -S /var/run/clamav/clamd.ctl ]; then
    echo "ERROR: ClamAV socket file still missing. Please check /etc/clamav/clamd.conf and restart ClamAV manually."
    exit 1
fi

# --------------------------
# Create Full System Scan Script
# --------------------------
echo "Creating full system scan script..."
cat <<EOF > /usr/local/bin/clamav_full_scan.sh
#!/bin/bash
LOGFILE="/var/log/clamav_full_scan.log"
EXCLUDE_DIRS="--exclude-dir=/sys --exclude-dir=/proc --exclude-dir=/dev --exclude-dir=/run"

echo "Starting full system scan..." | tee -a \$LOGFILE
clamscan -r --remove --bell --log=\$LOGFILE / \$EXCLUDE_DIRS
echo "Full system scan completed." | tee -a \$LOGFILE
EOF

chmod +x /usr/local/bin/clamav_full_scan.sh

# --------------------------
# Create ClamAV Database Update Script
# --------------------------
echo "Creating ClamAV database update script..."
cat <<EOF > /usr/local/bin/clamav_update_db.sh
#!/bin/bash
LOGFILE="/var/log/clamav_update.log"

echo "Updating ClamAV database..." | tee -a \$LOGFILE
systemctl stop clamav-freshclam
freshclam
systemctl start clamav-freshclam
echo "Database update completed." | tee -a \$LOGFILE
EOF

chmod +x /usr/local/bin/clamav_update_db.sh

# --------------------------
# Schedule Daily Full System Scan
# --------------------------
echo "Setting up daily full system scan..."
(crontab -l 2>/dev/null; echo "0 3 * * * /usr/local/bin/clamav_full_scan.sh") | crontab -

# --------------------------
# Schedule ClamAV Database Update Every 3 Months
# --------------------------
echo "Setting up ClamAV database update every 3 months..."
(crontab -l 2>/dev/null; echo "0 0 1 */3 * /usr/local/bin/clamav_update_db.sh") | crontab -

# --------------------------
# Initial Scan and Clamonacc Setup
# --------------------------
echo "Running initial full system scan..."
/usr/local/bin/clamav_full_scan.sh

echo "Starting Clamonacc On-Access Scanner..."
clamonacc --fdpass --config-file=/etc/clamav/clamd.conf &

echo "Setup and initial scan completed."
echo "Logs available at /var/log/clamav_full_scan.log"
echo "ClamAV database will be updated every 3 months automatically."
```
