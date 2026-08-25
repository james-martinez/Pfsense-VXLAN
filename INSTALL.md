How to install VXLAN support to Pfsense:
----------------------------------------
This repository is compatible with pfSense CE 2.9.0 (and 2.8.0/2.8.1; see legacy section below).

To install VXLAN on pfSense CE 2.9.0 :
1) Copy the files from the "boot", "etc" and "usr" folders onto the corresponding folders on your pfSense. This will modify existing files. You can also review the modifications and apply them by hand using the diff between the original pfSense files and the patched versions.
2) Copy the built `if_vxlan.ko` module into `/boot/kernel/` on your pfSense:
   scp if_vxlan.ko root@<pfsense-ip>:/boot/kernel/
3) Modify your /boot/loader.conf file on pfSense and add this line :
   if_vxlan_load="YES"
4) Reboot. To verify that the kernel module for VXLAN is working, SSH into your pfSense machine and enter this command : "kldstat". You should see a line with "if_vxlan.ko". You can also confirm the module exists (even before load) with :
   kldinfo -m if_vxlan
5) Use VXLAN with the pfSense GUI: Interfaces -> Assignments -> Interfaces, then choose "VXLAN" as the interface type.

---

How to install VXLAN support to Pfsense using System_Patches:
----------------------------------------
This repository is compatible with pfSense CE 2.9.0.

To install VXLAN on pfSense CE 2.9.0 :
1) Install System_Patches on your pfSense
2) Go to System -> Patches -> Add new patch
3) Enter "VXLAN Patch for 2.9.x" as name
4) Paste the git repo commit into URL/Commit ID:
   https://github.com/james-martinez/Pfsense-VXLAN/tree/2.9.0
5) Click Save.
6) Click Fetch to pull the git repo.
7) Click Apply.

---

Legacy — pfSense CE 2.8.0/2.8.1:
--------------------------------
The steps above also apply to 2.8.0/2.8.1, but build the module for that version instead.
See the `2.8.1` branch and BUILD.md (RELENG_2_7_2) for the older instructions.
