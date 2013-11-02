ucarp-mvip
==========

Helper to get multiple vips up under one interface with Debian's ucarp.
This is straight up grabbed from CentOS and crudely hacked to work within
Debian.

### Why whould I use this?
You shouldn't, no guarantees here. But if you do, you're probaly annoyed that
there's no convenient way to do this in Debian. Seeing the CentOS way of doing
the VIP's, I wanted it in my Debian too. So might you.

### Building The Package
http://www.debian.org/doc/manuals/maint-guide/build.en.html

TLDR; `dpkg-buildpackage -us -uc -b`

### Usage

Configure your carp interfaces in `/etc/network/interfaces` as such:

```
  auto eth0:carp0
  iface eth0:carp0 inet static
        address 192.168.1.110
        netmask 255.255.255.0

  auto eth0:carp1
  iface eth0:carp1 inet static
        address 192.168.1.120
        netmask 255.255.255.0
```

Then copy vip example from `/usr/doc/ucarp-mvip/examples/` to `/etc/ucarp-mvip/`
and configure them as you please. Don't forget to `auto` the carp interfaces
as we're lazily using `ifquery`.

Vip config examples for **one** server using the above `/etc/network/interfaces`
example could look like:
* `/etc/ucarp-mvip/vip-010.conf`

```
PASSWORD="love"
BIND_INTERFACE="eth0"
VIP_INTERFACE="eth0:carp0"
OPTIONS="-k 1 -P -n"
```

* `/etc/ucarp-mvip/vip-020.conf`

```
PASSWORD="love"
BIND_INTERFACE="eth0"
VIP_INTERFACE="eth0:carp1"
OPTIONS="-k 100 -n"
```

And in the **second** server the vip configs would be:

* `/etc/ucarp-mvip/vip-010.conf`

```
PASSWORD="love"
BIND_INTERFACE="eth0"
VIP_INTERFACE="eth0:carp0"
OPTIONS="-k 100 -n"
```

* `/etc/ucarp-mvip/vip-020.conf`

```
PASSWORD="love"
BIND_INTERFACE="eth0"
VIP_INTERFACE="eth0:carp1"
OPTIONS="-k 1 -P -n"
```
