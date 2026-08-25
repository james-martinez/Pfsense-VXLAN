Pfsense VXLAN implementation:
-----------------------------
This is a repository to add VXLAN support to Pfsense CE. pfSense CE does not
ship the `if_vxlan` kernel module by default, so this repo provides a compiled
module plus the GUI edits needed to create and manage VXLAN interfaces.

Supported versions:
- **2.9.0** (current) — FreeBSD 16.0-CURRENT @ RELENG_2_9_0 / commit 4bdcff55436859420e090afb0e6932bab794baa4
- 2.8.0/2.8.1 (legacy) — FreeBSD 13.x @ RELENG_2_7_2

See the `2.8.1` branch for the older module and GUI edits.

Installation:
-------------
To install VXLAN on pfSense CE 2.9.0, see INSTALL.md

Build from sources:
-------------------
If you want, you can build the kernel module from sources : see BUILD.md

Sources:
--------
[Pfsense sources](https://github.com/pfsense/FreeBSD-src).

[FreeBSD sources](https://github.com/freebsd/freebsd-src).

Note: pfSense Plus 25.11 (and later) ships VXLAN support natively, so this
patch is only needed for pfSense CE, which does not enable `if_vxlan` by default.
