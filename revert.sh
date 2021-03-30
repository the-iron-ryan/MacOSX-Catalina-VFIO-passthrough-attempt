#!/bin/bash
set -x
  
# Load GPU passthrough vars
source "/etc/libvirt/hooks/kvm.conf"

# Load VFIO Kernel Module  
modprobe -r vfio_pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

# Re-Bind GPU to Nvidia Driver
virsh nodedev-reattach $VIRSH_GPU_VIDEO 
virsh nodedev-reattach $VIRSH_GPU_AUDIO 

# Rebind VT consoles
echo 1 > /sys/class/vtconsole/vtcon0/bind

# Bind EFI-framebuffer. Commented out because known to cause segfault
#echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

# Reload AMD drivers
modprobe amdgpu
modprobe drm
modprobe snd_hda_intel

# Restart Display Manager
systemctl start sddm.service
