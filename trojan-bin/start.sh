#!/bin/bash

# Written by RCD-Y

# Kill all running instances
pgrep trojan && killall trojan

# Find the proxy port in the specified config file using regex
proxy_port=`cat "$1" | grep -oE "((local_port[\"'])[: ]+)\d+" | head -n 1 | grep -oE "\d+"`

# Configure SOCKS proxy
networksetup -setsocksfirewallproxy "Wi-Fi" 127.0.0.1 $proxy_port

# Change to the executable's local directory
cd "$(dirname "$0")"

# Run Trojan with specified config
./trojan "$1"
