# TrojanX

## What is TrojanX?

TrojanX is a bare-bones, minimal GUI client on Mac for Trojan, written in Swift and shell.

## Quick Start Guide

1. Download a precompiled version of the app from the release tab and drag it to your Applications folder.

2. Open the app; a menu bar icon depicting a horse head should appear.
3. Click on the menu bar icon, and select "About..." from the dropdown menu. A window should open up.
4. Click "Open configuration folder".
5. Put your configuration files, certificates, etc. for trojan insde the opened directory. For the app to recognize a file as a piece of configuration to pipe into trojan, make sure they end in `.json`. Use a descriptive name like `"Tokyo Server.json"`.
   - Side note: all file paths inside the configuration file should be relative to trojan executable, which is located in the parent directory of the configuration folder. This means that if you placed a certificate like `cert.pem` inside the configuration folder, you'll need to refer to it as `conf/cert.pem` inside the JSON.
6. If you are not using Wi-Fi as your primary network interface name, perform the steps in the guide [here](#if-you-are-not-using-wi-fi), otherwise skip this step.
7. Relaunch the app, and you should now see your newly added configuration selected in the drop down menu from the status bar icon.
8. Click `Start Trojan` and you're set!

## Updating the Trojan Binary

In order to update the trojan binary, download the latest version from the [trojan GitHub page](https://github.com/trojan-gfw/trojan) for your platform and replace the bundled binary located one level above the configuration folder (the Resources folder inside the app). 

## If you are not using Wi-Fi

TrojanX uses shell scripts to set up the system to use SOCKS proxy. If you do not use Wi-Fi, you'll need to change the shell scripts to reflect that, or otherwise TrojanX will not be able to set up proxy for you.

The shell scripts are located in the same directory as the trojan binary, which is one level about the configuration folder. Locate `start.sh` and `stop.sh`, and swap out all occurrences of `"Wi-Fi"` with whatever you use. You can find a list of network service names by running `networksetup -listnetworkserviceorder` in Terminal. Usually the first entry is what you want to put in.

In the future I would probably want to automate this, but for now this will do.

## Where's the option for local port?

TrojanX uses regex magic to detect which port you specified in the config file, so as long as your file isn't too funky, system proxy will be automatically set up at the correct port.

## Some Notes

- Since I don't have much free time, this project will probably not be updated very often. This means that the binary is going to be really old and you'll probably end up updating on your own.
- Post issues on the issues page and I'll try to address them. Chinese can be used. However, don't post anything regarding trojan itself as I won't be able to answer them.
- This app is after all a bare-bones GUI client since I wrote it in a hurry. If you have any ideas to improve upon my current (crappy) code, feel free to contribute.
