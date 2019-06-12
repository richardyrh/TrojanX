#!/bin/bash

# Written by RCD-Y

# Revert SOCKS settings
networksetup -setsocksfirewallproxystate "Wi-Fi" off

# Terminate Trojan
killall trojan
