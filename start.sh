#!/bin/bash
# Helpful to read output when debugging
set -x

# Load GPU passthrough vars
source "/etc/libvirt/hooks/kvm.conf"

# Stop display manager
systemctl stop sddm.service

# Stop pulse audio 
pulse_pid=$(pgrep -u the-iron-ryan pulseaudio)
pipewire_pid=$(pgrep -u the-iron-ryan pipewire-media)
kill $pulse_pid
kill $pipewire_pid

# Unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind

# Unbind EFI-Framebuffer. Commented out because known to cause seg-fault
#echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Avoid a Race condition
sleep 4

# Unload AMD drivers
modprobe -r amdgpu
#modprobe -r drm
#modprobe -r snd_hda_intel

# Unbind the GPU from display driver
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO

# Load VFIO Kernel Module  
modprobe vfio
modprobe vfio_pci
modprobe vfio_iommu_type1
