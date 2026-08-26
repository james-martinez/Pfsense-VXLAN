# Building the VXLAN kernel module

Build `if_vxlan.ko` on a FreeBSD system or virtual machine. Building on FreeBSD 15.x or newer works. The module takes its version stamp from the source checkout, so it loads on pfSense CE 2.9.0 without issues.

## 1. Clone FreeBSD source code

Clone the FreeBSD source tree at commit `4bdcff554368`, which matches pfSense CE 2.9.0:

```sh
git clone https://github.com/freebsd/freebsd-src.git
cd freebsd-src
git checkout 4bdcff55436859420e090afb0e6932bab794baa4
```

## 2. Compile the module

```sh
cd sys/modules/if_vxlan
make
```

The build writes `if_vxlan.ko` to `/usr/obj/`.

## 3. Verify the version stamp

Check that the module version matches `1600018`:

```sh
kldinfo -v /usr/obj/$(pwd)/if_vxlan.ko
```

See [INSTALL.md](INSTALL.md) to install the built module.

## Legacy versions (pfSense 2.8.0 and 2.8.1)

To build for pfSense 2.8.0 or 2.8.1, check out the FreeBSD 13.x source tree and compile `sys/modules/if_vxlan`. See the `2.8.1` branch for commit details.
