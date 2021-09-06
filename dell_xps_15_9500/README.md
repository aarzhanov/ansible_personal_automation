# Install base system

* Download Arch ISO https://archlinux.org/download/
* Create Boot USB flash:
```
   cat /path/to/archlinux-version-x86_64.iso > /dev/path/to/usb/flash
```
* Boot from USB flash
* Switch to DE keyboard:
```
   loadkeys de-latin1
```
* Connect to the internet, for Wi-Fi authenticate to the wireless network use "iwctl"
* Install git:
```
   pacman -S git
```
* Git clone this repo
* Go to this directory:
```
   cd ansible_personal_automation/dell_xps_15_9500/
```
* Run script:
```
   bash base.sh
```
