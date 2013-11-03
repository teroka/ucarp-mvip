ucarp-mvip
==========

`ucarp-mvip` is a helper package on top of [ucarp](http://www.ucarp.org/) to get
multiple vips up under one interface with Debian's ucarp package. This is
straight up grabbed from CentOS and hacked to work within Debian.

### Why whould I use this?
You shouldn't, no guarantees here. But if you do, you're probably annoyed that
there's no convenient way to do this in Debian. Seeing the CentOS way of doing
the VIP's, I wanted it in my Debian too. As might you.

### Building The Package
http://www.debian.org/doc/manuals/maint-guide/build.en.html

TLDR; `dpkg-buildpackage -us -uc -b`

### Usage

First enable the `ucarp-mvip` from `/etc/default/ucarp-mvip`.
Then configure your carp interfaces in `/etc/network/interfaces` as such:

```
  iface eth0:carp0 inet static
        address 192.168.1.110
        netmask 255.255.255.0

  iface eth0:carp1 inet static
        address 192.168.1.120
        netmask 255.255.255.0
```

Then copy vip example from `/usr/doc/ucarp-mvip/examples/` to `/etc/ucarp-mvip/`
and configure them as you please. 

Vip configs for your **first** server using the above `/etc/network/interfaces`
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

Then restart the `ucarp-mvip`: `/etc/init.d/ucarp-mvip restart`
