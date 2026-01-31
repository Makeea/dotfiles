#!/bin/bash

# Only run for interactive shells
[[ $- != *i* ]] && return

clear

echo "==============================================="
echo "🖥️   WSL SYSTEM INFO"
echo "==============================================="
echo "User:        $USER"
echo "Hostname:    $(hostname)"
echo "Distro:      $(lsb_release -ds 2>/dev/null || grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')"
echo "Kernel:      $(uname -r)"
echo "Uptime:      $(uptime -p)"
echo "IP Address:  $(hostname -I | awk '{print $1}')"
echo "Disk Usage:  $(df -h / | awk 'NR==2{print $5}')"
echo "Date:        $(date)"
echo "==============================================="
