To build the VXLAN kernel module:
---------------------------------

1) You need a FreeBSD machine (or VM). FreeBSD 16-CURRENT is recommended for building the 2.9.0 module.
2) Clone Pfsense src on this FreeBSD machine using the exact same branch as your Pfsense version.
   For pfSense CE 2.9.0 : \
   git clone --branch RELENG_2_9_0 https://github.com/pfsense/FreeBSD-src.git /usr/src/
3) cd /usr/src/sys/modules/if_vxlan
4) Run make
You will find kernel module "if_vxlan.ko" file in /usr/obj/directory.
See INSTALL.md to install it.

For versions on a non release branch, devel-main :
---
1) go to https://docs.netgate.com/pfsense/en/latest/releases/versions.html
2) check the commit for your version. For pfSense CE 2.9.0 use \
   4bdcff55436859420e090afb0e6932bab794baa4 (16.0-CURRENT @ RELENG_2_9_0). \
   git clone --branch devel-main https://github.com/pfsense/FreeBSD-src.git
3) cd FreeBSD-src/sys/modules/if_vxlan
4) git checkout 4bdcff55436859420e090afb0e6932bab794baa4
5) Run make
You will find kernel module "if_vxlan.ko" file in /usr/obj/\<src>/\<arch>/sys/modules/if_vxlan/ directory.
See INSTALL.md to install it.

For legacy pfSense CE 2.8.0/2.8.1 : \
git clone --branch RELENG_2_7_2 https://github.com/pfsense/FreeBSD-src.git /usr/src/
then cd /usr/src/sys/modules/if_vxlan and make. See the 2.8.1 branch for older instructions.
