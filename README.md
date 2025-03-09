# Project: Linux Security & Hardening Scripts
This repository contains a set of Bash scripts aimed at enhancing the security, performance, and malware protection of Linux-based systems. These scripts are designed to assist system administrators in automating security configurations, detecting and removing malware, and optimizing system performance.

Table of Contents
1 clamAv.sh
2 my-remediation-script.sh
3 tunning.sh

# 1-clamAv.sh
This script installs, configures, and runs ClamAV, an open-source antivirus engine for detecting malware on Linux systems.

Features:
Installs ClamAV if not already installed.
Updates the malware signature database (freshclam).
Runs a full system scan.
Generates a scan report to log infected files.
Can be scheduled for automated periodic scans using cron.

# 2- my-remediation-script.sh (ubuntu 22.04)
This script is designed to remediate security vulnerabilities by implementing essential hardening measures on a Linux system.

Features:
Disables unnecessary services to reduce attack surface.
Enforces secure file permissions to prevent unauthorized access.
Removes unnecessary packages that could be exploited.
Applies security patches and updates (apt update && apt upgrade).
Configures firewall rules for better network security.

# 3- tunning.sh
This script is used for performance tuning and system optimization in Linux environments.

Features:
Optimizes kernel parameters for better performance.
Configures swap space and memory settings for efficient resource usage.
Adjusts network parameters for faster data transmission.
Cleans up unnecessary files and logs to free up disk space.
Can be customized for specific system performance requirements.
