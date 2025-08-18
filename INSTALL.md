How to install VXLAN support to Pfsense:
----------------------------------------
This repository is compatible with Pfsense CE 2.7.2

To install VXLAN on Pfsense CE 2.7.2 :
1) Copy the files from the "boot", "etc" and "usr" folder on corresponding folders on your Pfsense. This will modify existing files. You can also see the modification and apply it by hand on those file on your Pfsense for the diff between the first (original Pfsense files) and second commit.
2) Modify your /boot/loader.conf file on Pfsense and add this line :
if_vxlan_load="YES"
3) Reboot. To verify that the kernel module for VXLAN is working SSH on you Pfsense machine and enter this command : "kldstats". You should see a line with "if_vxlan.ko"
4) Use VXLAN with Pfsense GUI


How to install VXLAN support to Pfsense using System_Patches:
----------------------------------------
This repository is compatible with Pfsense CE 2.8.0

To install VXLAN on Pfsense CE 2.8.0 :
1) Install System_Patches on your pfsense
2) Go to System -> Patches -> Add new patch
3  Enter VXLAN Patch for 2.8.0 for name
4) Paste git repo commit into URL/Commit ID: https://github.com/james-martinez/Pfsense-VXLAN/commit/83458c4feb70e99f4cc8360428ae7a78dc8417ec
5) Click Save.
6) Click Fetch to pull git repo.
7) Click Apply.
