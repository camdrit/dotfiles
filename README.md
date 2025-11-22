# dotfiles

Cam's Dots. Da dippin dots. Deez r dah best dotz

## Hey, dumbass: Don't forget this shit

### Symbolic links to library folders

You put your personal data on another partition. Run this:

```bash
rm -rf ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Public ~/Templates ~/Videos
ln -s /mnt/data/Desktop /home/cam/Desktop
ln -s /mnt/data/Documents /home/cam/Documents
ln -s /mnt/data/Downloads /home/cam/Downloads
ln -s /mnt/data/Music /home/cam/Music
ln -s /mnt/data/Pictures /home/cam/Pictures
ln -s /mnt/data/Public /home/cam/Public
ln -s /mnt/data/Templates /home/cam/Templates
ln -s /mnt/data/Videos /home/cam/Videos
```

### Ethernet Sleep Bug

Your shitty mobo's shitty onboard ethernet goes to sleep after a while
and then it doesn't work again until you run a stupid command or reboot.

Fix:

```
# put this in your grub cmdline you stupid shit
pcie_port_pm=off pcie_aspm.policy=performance
```

Remember to update grub, dumbass

### IOMMU / GPU Passthrough

These options will passthrough your integrated GPU to kvm:

```
# again, in grub cmdline
amd_iommu=on iommu=pt pci-stub.ids=1002:164e,1002:1640 rd.driver.pre=vfio-pci
```

Make sure to update the stub IDs if you decide to add a second dGPU later...

Also, add this to `/etc/dracut.conf.d/local.conf`:

```
force_drivers+=" vfio vfio_iommu_type1 vfio_pci pci-stub "
```

Finally, run:

```
sudo dracut -f --kver `uname -r`
```

And also update grub!!!!

Next, add your passthrough gpu bios/rom to kvm:

```
sudo mkdir -p /usr/share/kvm/vbios
sudo cp vbios_164e.dat /usr/share/kvm/vbios/
sudo cp AMDGopDriver.rom /usr/share/kvm/vbios/
```

### Razer Middle Mouse Button

Razer's shitty mouse button doesn't work. Run this:

```
echo -n -e "\x03\x00" | sudo tee /sys/bus/hid/drivers/razermouse/0*/device_mode
```

### Monitor Weirdness

Your shitty monitor acts weird but adding its firmware to boot options (above) helps.
You need to supply the firmware file, tho:

```
sudo cp samsung_bg65_edid.bin /lib/firmware/edid/
```

Then edit your grub cmdline:

```
drm.edid_firmware=DP-1:edid/samsung_bg65_edid.bin
```

update grub, then:

```
sudo dracut --force --install /lib/firmware/edid/samsung_bg65_edid.bin /boot/initramfs-$(uname -r).img $(uname -r)
```

### KVM stuff

Make sure to follow the passthrough shit above.

Make sure you own kvmfr (the framebuffer that looking glass shits to):

```
# /etc/udev/rules.d/99-kvmfr.rules
SUBSYSTEM="kvmfr", OWNER="cam", GROUP="kvm", MODE="0660"
```

Make sure that shit exists:

```
# /etc/modules-load.d/kvmfr.conf
#KVMFR Looking Glass module
kvmfr
```

Copy your windows vm config:

```
sudo cp win11.xml /etc/libvirt/qemu/win11.xml
```

Build options for Looking Glass:

```
cmake -DENABLE_X11=no -DENABLE_PULSEAUDIO=no -DENABLE_LIBDECOR=ON ../
```

Add yourself to the correct groups:

```
newgrp libvirt # if it don't exist
sudo usermod -aG kvm,libvirt $USER
```
