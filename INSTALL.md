# Installing VXLAN on pfSense CE 2.9.0

pfSense CE does not include the FreeBSD `if_vxlan` kernel module or VXLAN web interface options. This repository provides both.

You can install via the pfSense System Patches web package (recommended) or manually via SSH.

---

## Method 1: pfSense System Patches package (web GUI)

The patch includes both the PHP web interface modifications and an embedded copy of the compiled `if_vxlan.ko` kernel module. Applying the patch automatically extracts and loads the module when you open the VXLAN interface pages.

### Step 1: Install System Patches

1. In the pfSense web GUI, go to **System > Package Manager > Available Packages**.
2. Search for `System_Patches`.
3. Click **Install**, then **Confirm**.

### Step 2: Add the VXLAN patch

1. Go to **System > Patches**.
2. Click **Add New Patch**.
3. Fill in the fields:
   - **Description:** `VXLAN Support for pfSense CE 2.9.0`
   - **URL/Commit ID:**
     ```
     https://raw.githubusercontent.com/james-martinez/Pfsense-VXLAN/2.9.0-patch/vxlan-2.9.0.patch
     ```
   - **Path Strip Count:** `1` (change this from the default of 2 to 1)
   - **Base Directory:** `/`
   - **Auto Apply:** Checked (ensures the patch re-applies after minor system updates)
4. Click **Save**.

### Step 3: Fetch and apply

1. On the Patches list, find the new VXLAN entry.
2. Click **Fetch** to download the patch.
3. Click **Test** to verify that all files show green status.
4. Click **Apply**.

The module automatically extracts to `/boot/modules/if_vxlan.ko`, loads into the kernel, and registers in `/boot/loader.conf.local` for persistence across reboots.

---

## Method 2: Manual installation (SSH / CLI)

If you prefer applying files directly over SSH:

### Step 1: Copy files to pfSense

Clone the repository and copy the `boot`, `etc`, and `usr` directories to the root filesystem:

```sh
scp -r boot etc usr root@<pfsense-ip>:/
```

### Step 2: Set permissions and load the kernel module

SSH into your pfSense host and run:

```sh
chmod 0555 /boot/modules/if_vxlan.ko
echo 'if_vxlan_load="YES"' >> /boot/loader.conf.local
kldload -n /boot/modules/if_vxlan.ko
```

---

## Verifying installation

1. **Verify kernel module:**
   SSH into pfSense and run:
   ```sh
   kldstat | grep vxlan
   ```
   Output should show `if_vxlan.ko`.

2. **Access the web GUI:**
   - Go to **Interfaces > Assignments**.
   - Click the **VXLAN** tab (or navigate directly to `/interfaces_vxlan.php`).
   - Click **Add** to create a new VXLAN tunnel interface.
   - Set your VNI, Local IP, and Remote IP (or Multicast Group).
   - Click **Save** and **Apply Changes**.
   - Return to **Interfaces > Assignments** and assign the new `vxlan0` interface to a firewall interface.

---

## Legacy versions (pfSense CE 2.8.0 / 2.8.1)

For pfSense 2.8.0 and 2.8.1, switch to the `2.8.1` branch for the compatible kernel module binary and PHP base files:

```
https://github.com/james-martinez/Pfsense-VXLAN/tree/2.8.1
```
