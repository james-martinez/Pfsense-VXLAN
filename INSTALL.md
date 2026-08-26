# Installing VXLAN on pfSense CE 2.9.0

pfSense CE does not include the FreeBSD `if_vxlan` kernel module or VXLAN configuration menus. This repository provides both.

You can install through the pfSense System Patches web package or manually over SSH.

## Method 1: pfSense System Patches package (web GUI)

The patch modifies the web interface and includes a base64-encoded copy of `if_vxlan.ko`. Applying the patch writes the module to `/boot/modules/`, loads it into the kernel, and configures `/boot/loader.conf.local` for persistence across reboots.

### Step 1: Install System Patches

1. In the pfSense web GUI, go to **System > Package Manager > Available Packages**.
2. Search for `System_Patches`.
3. Click **Install**, then **Confirm**.

### Step 2: Add the VXLAN patch

1. Go to **System > Patches**.
2. Click **Add New Patch**.
3. Enter these settings:
   - **Description:** `VXLAN Support for pfSense CE 2.9.0`
   - **URL/Commit ID:**
     ```
     https://raw.githubusercontent.com/james-martinez/Pfsense-VXLAN/2.9.0-patch/vxlan-2.9.0.patch
     ```
   - **Path Strip Count:** `1`
   - **Base Directory:** `/`
   - **Auto Apply:** Checked
4. Click **Save**.

### Step 3: Fetch and apply

1. Find the new patch in the list.
2. Click **Fetch**.
3. Click **Test** to confirm clean application.
4. Click **Apply**.

The web interface is updated and the kernel module loads immediately.

## Method 2: Manual installation (SSH)

If you prefer applying files directly over SSH:

### Step 1: Copy files to pfSense

Copy the `boot`, `etc`, and `usr` directories to the root filesystem:

```sh
scp -r boot etc usr root@<pfsense-ip>:/
```

### Step 2: Set permissions and load the module

SSH into your pfSense host and run:

```sh
chmod 0555 /boot/modules/if_vxlan.ko
echo 'if_vxlan_load="YES"' >> /boot/loader.conf.local
kldload -n /boot/modules/if_vxlan.ko
```

## Verifying the installation

1. Check that the kernel module is loaded:
   ```sh
   kldstat | grep vxlan
   ```
   The command should print a line showing `if_vxlan.ko`.

2. Open the web GUI:
   - Go to **Interfaces > Assignments**.
   - Click the **VXLAN** tab.
   - Click **Add** to create a tunnel interface.
   - Enter your VNI, Local IP, and Remote IP or Multicast Group.
   - Click **Save** and **Apply Changes**.
   - Return to **Interfaces > Assignments** and assign `vxlan0` to an interface.

## Legacy versions

For pfSense 2.8.0 and 2.8.1, switch to the `2.8.1` branch for the compatible module and base files:

```
https://github.com/james-martinez/Pfsense-VXLAN/tree/2.8.1
```
