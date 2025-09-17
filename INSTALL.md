How to install VXLAN support to Pfsense:
----------------------------------------
This repository is compatible with Pfsense CE 2.8.0/2.8.1

To install VXLAN on Pfsense CE 2.8.0/2.8.1 :
1) Copy the files from the "boot", "etc" and "usr" folder on corresponding folders on your Pfsense. This will modify existing files. You can also see the modification and apply it by hand on those file on your Pfsense for the diff between the first (original Pfsense files) and second commit.
2) Modify your /boot/loader.conf file on Pfsense and add this line :
if_vxlan_load="YES"
3) Reboot. To verify that the kernel module for VXLAN is working SSH on you Pfsense machine and enter this command : "kldstat". You should see a line with "if_vxlan.ko"
4) Use VXLAN with Pfsense GUI


How to install VXLAN support to Pfsense using System_Patches:
----------------------------------------
This repository is compatible with Pfsense CE 2.8.0/2.8.1

To install VXLAN on Pfsense CE 2.8.0/2.8.1 :
1) Install System_Patches on your pfsense
2) Go to System -> Patches -> Add new patch
3)  Enter VXLAN Patch for 2.8.x for name
4) Paste git repo commit into URL/Commit ID: `https://github.com/james-martinez/Pfsense-VXLAN/commit/9636d5c6b1413e8e3f7a4876469633171c09e73d`
5) Click Save.
6) Click Fetch to pull git repo.
7) Click Apply.
