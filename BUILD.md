To build the VXLAN kernel module:
---------------------------------

1) You need a FreeBSD machine (or VM)
2) Clone Pfsense src on this FreeBSD machine using the exact same branch as your Pfsense version
for Pfsense CE 2.7.2 : \
git clone --branch RELENG_2_7_2 https://github.com/pfsense/FreeBSD-src.git /usr/src/
3) cd /usr/src/sys/modules/if_vxlan
4) Run make
You will find kernel module "if_vxlan.ko" file in /usr/obj/directory.
See INSTALL.md to install it.

For versions on a non release branch, devel-main :
---
1) go to https://docs.netgate.com/pfsense/en/latest/releases/versions.html
2) check the commit for your version. for example, pfSense CE 2.8.0 uses bf06074106cf \
   git clone --branch devel-main https://github.com/pfsense/FreeBSD-src.git /usr/src
3) cd /usr/src/sys/modules/if_vxlan
4) git checkout bf06074106cf
5) Run make
You will find kernel module "if_vxlan.ko" file in /usr/obj/directory.
See INSTALL.md to install it.
