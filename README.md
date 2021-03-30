`start.sh` and `revert.sh` are the two qemu hook scripts I've been using to unload AMD drivers and passthrough my single rx580 GPU. I've been going off this amd passthrough guide as a reference: https://github.com/cosminmocan/vfio-single-amdgpu-passthrough

`kvm.conf` is what I use to simply define the PCI ids for my GPU and its audio controller - nothing fancy here.

`MacOSX.xml` is my complete kvm/qemu config for my Mac VM. I'm running Catalina btw. As far as I'm concerned, this is setup correctly. I've been able to get this running just fine through a spice display and via a passthrough of a NVIDIA 2080 gpu. Although doing so with a 2080 is pointless since Apple doesn't support nvidia drivers anymore :(

`580bios.rom` is the vbios file I flashed from my gpu via techpowerup's ATIFlash tool. Ideally I'd just download the bios file directly from their site's database, but they didn't have a vbios for the XFX 580 GTS XXX 8Gb edition, so I had to do so myself. I did so using their Win10 tool on a small dual boot of windows I run - not sure if this makes a difference if I used their linux tool or not, but thought it's worth mentioning. Also I did *not* patch my rom - I've read a couple places online that you generally don't need to patch AMD cards.
