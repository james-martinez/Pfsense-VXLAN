To build the VXLAN kernel module:
---------------------------------

1) You need a FreeBSD machine (or VM). FreeBSD 15.x or newer works for building;
   the module is stamped with the version from the source tree you clone below,
   so it will load on pfSense CE 2.9.0's FreeBSD 16-CURRENT kernel regardless.

2) Clone the FreeBSD base sources at the exact commit pfSense CE 2.9.0 uses:
   git clone https://github.com/freebsd/freebsd-src.git
   cd freebsd-src
   git checkout 4bdcff55436859420e090afb0e6932bab794baa4
   (This is 16.0-CURRENT @ commit 4bdcff5, the base pfSense CE 2.9.0 ships.)

3) Build the module:
   cd sys/modules/if_vxlan
   make

You will find the kernel module "if_vxlan.ko" file in /usr/obj/.
See INSTALL.md to install it.

Verify the module stamp before installing (must match __FreeBSD_version 1600018):
   kldinfo -v /path/to/if_vxlan.ko

Legacy pfSense CE 2.8.0/2.8.1 :
---
Build against FreeBSD 13.x sources instead:
   git clone https://github.com/freebsd/freebsd-src.git
   cd freebsd-src
   git checkout <FreeBSD 13.x commit for your pfSense version>
   cd sys/modules/if_vxlan && make
See the 2.8.1 branch for older instructions.
