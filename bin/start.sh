#!/bin/bash

# Written by RCD-Y

# Kill all running instances
pgrep trojan && killall trojan

# Change to config directory
cd "$1"

# Find the proxy port in the specified config file using regex
proxy_port=`cat "$2" | grep -oE "((local_port[\"'])[: ]+)\d+" | head -n 1 | grep -oE "\d+"`

# Configure SOCKS proxy
networksetup -setsocksfirewallproxy "Wi-Fi" 127.0.0.1 $proxy_port

# Run Trojan with specified config
$(dirname "$0")/trojan "$2"
