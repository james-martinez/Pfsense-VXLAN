# pfSense CE VXLAN implementation

Adds VXLAN tunnel support and GUI management to pfSense Community Edition. 

pfSense CE does not include the `if_vxlan` kernel module or VXLAN web interface options. This repository provides the pre-compiled kernel module for FreeBSD 16-CURRENT and the pfSense PHP base system modifications to configure, assign, and manage VXLAN interfaces through the web GUI.

## Supported versions

- **pfSense CE 2.9.0-DEVELOPMENT** (current branch `2.9.0` / `2.9.0-patch`)
  - Kernel module built from FreeBSD 16.0-CURRENT @ commit `4bdcff554368`
- **pfSense CE 2.8.0 / 2.8.1** (legacy branch `2.8.1`)
  - Kernel module built from FreeBSD 13.x @ `RELENG_2_7_2`

*Note: pfSense Plus 25.11 and later includes VXLAN natively. This repository targets pfSense CE.*

## Installation

See [INSTALL.md](INSTALL.md) for full instructions.

### Quick start with System Patches

1. Install the **System_Patches** package via pfSense Package Manager.
2. In **System > Patches**, add a new patch with:
   - **URL/Commit ID:** `https://raw.githubusercontent.com/james-martinez/Pfsense-VXLAN/2.9.0-patch/vxlan-2.9.0.patch`
   - **Path Strip Count:** `1`
   - **Base Directory:** `/`
3. Click **Fetch**, test, and **Apply**.

The kernel module self-extracts, loads, and sets boot persistence automatically when applied.

## Building from source

To compile the `if_vxlan.ko` kernel module yourself against FreeBSD sources, see [BUILD.md](BUILD.md).
