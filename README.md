# pfSense CE VXLAN

VXLAN tunnel support and GUI management for pfSense Community Edition.

pfSense CE does not ship the FreeBSD `if_vxlan` kernel module or web interface menus for VXLAN. This repository provides the pre-compiled kernel module for FreeBSD 16-CURRENT and the base system files needed to configure and assign VXLAN interfaces in the web GUI.

## Supported versions

- pfSense CE 2.9.0-DEVELOPMENT (branch `2.9.0`)
  - Kernel module built from FreeBSD 16.0-CURRENT, commit `4bdcff554368`
- pfSense CE 2.8.0 and 2.8.1 (branch `2.8.1`)
  - Kernel module built from FreeBSD 13.x, `RELENG_2_7_2`

pfSense Plus 25.11 and later includes VXLAN natively. This project is for pfSense CE.

## Quick start

The fastest way to install is with the pfSense System Patches package:

1. Install the `System_Patches` package in pfSense.
2. Go to **System > Patches** and click **Add New Patch**.
3. Set **URL/Commit ID** to:
   ```
   https://raw.githubusercontent.com/james-martinez/Pfsense-VXLAN/2.9.0/vxlan-2.9.0.patch
   ```
4. Set **Path Strip Count** to `1`.
5. Keep **Base Directory** as `/`.
6. Click **Save**, then **Fetch**, then **Apply**.

The patch automatically writes `if_vxlan.ko` to `/boot/modules/`, loads it, and adds the boot loader entry in `/boot/loader.conf.local`.

See [INSTALL.md](INSTALL.md) for detailed instructions and manual installation steps.

## Building from source

To compile `if_vxlan.ko` yourself against FreeBSD source code, see [BUILD.md](BUILD.md).
