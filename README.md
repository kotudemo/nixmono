![Screenshot_20241031_011623](https://github.com/user-attachments/assets/f7ce3e4e-299b-444a-ace2-9106fdf6fb40)
![image](https://github.com/user-attachments/assets/4cfdc724-c451-4147-b885-fde028a74b38)

<h1 align=center> TO DO </h1>
<ol>
  <li>Flake for properly packaged UFR II printer driver</li>
  <li>Flake for properly packaged XP-Pen driver</li>
  <li>Move games to custom option</li>
  <li>Declare Firefox <code>user_prefs</code> and extensions</li>
  <li>Declare Spicetify extensions (I'm going to fork Gerg-L's Spicetify flake to add all marketplace support and also make a parser to convert your <code>marketplace backup.txt</code> to <code>spicetify.nix</code>)</li>
  <li>Declare <a href="https://github.com/KaylorBen/nixcord">Vencord extensions</a></li>
  <li>Declare Flatpaks</li>
  <li>Disko</li>
  <li><code>nixos-anywhere</code> installation guide</li>
  <li>Declare option in <code>passtrough.nix</code> for AMD</li>
  <li>Wrap everything to options to make your Nix experience more customizable</li>
  <li>Add Home Manager configuration to use <code>home-manager rebuild</code></li>
  <li>Declare Starship</li>
  <li>Declare Git and Zerotier secrets with SOPS and AgeNix</li>
  <li>Declare Docker</li>
  <li>Move most packages to Home Manager and separate them into one file</li>
  <li>Randomized wallpaper option after HMS</li>
  <li>Declare <a href="https://github.com/nix-community/plasma-manager">KDE settings</a></li>
  <li>Migration to WM with Pywal, <a href="https://search.nixos.org/packages?channel=unstable&show=autotiling-rs&from=0&size=50&sort=relevance&type=packages&query=autotiling-rs">autotiling</a>, and Stylix (???)</li>
</ol>

<h1 align=center> GPU passthrough for gaming on Windows VM </h1>

<h2 align=center> DISCLAIMER </h2>

**If your pc too low-end like Intel Core i7-6700K + GeForce GTX 680 the best thing you can do is dual-booting Windows 10. You also need CPU with iGPU or second dGPU to be left for your Linux system. Also you want to have CPU like r7 7700x to handle both systems at the same time.** 

**The following guideline's gonna work if your setup is powered by Nvidia (GTX 1000+) and Intel CPU (core 10 gen or lower with with iGPU (for newer iGPU you have to change ```hardware.graphics.extraPackages```)). Otherwise, you gonna have to do a lot of changes in passthrough.nix. There are some links below might be useful to adjust your configuration for AMD GPU and some optimizations for lower latency and higher perfomance.**  

https://discourse.nixos.org/t/nixos-vfio-gpu-passthrough/41169/2 \
https://gist.github.com/techhazard/1be07805081a4d7a51c527e452b87b26 \
https://discourse.nixos.org/t/single-gpu-passthrough/44119/2 \
https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Attaching_the_PCI_devices \
https://forum.level1techs.com/t/solved-help-with-dual-nvidia-gpu-and-looking-glass/190084/17

<h2 align=center> How To Guide </h2>

First of all you have to enter BIOS and enable iGPU (because your dGPU will be caged in your VM and will not be accessible in your Linux until you reboot to regular configuration), Virtualization and Intel VT-d, plug HDMI/DP/VGA cable to your motherboard and change your monitor settings to set input method to your new cable. Do not unplug video cable from your gpu because it necessary  for ```looking-glass``` correct work (however you can try to configure virtual montitor).

Then you need to enable ```passthrough``` option in ```configuration.nix``` and change PCI IDs at the top of the former one. To do that use ```lspci -nn | grep -iE '(nvidia|amd)'``` for audio and graphics PCI IDs and ```sudo lshw -c display``` for nvidia prime bus ids. Then create Windows VM with virt-manager, install Windows and ```looking-glass```,```spice``` and ```scream``` drivers, reboot your pc, add your GPU and Audio Controller isolated earlier in your VM settings by clicking ```Add Hardware``` (they are in the PCI Host Device section) and after that change your VM .xml file to add some anticheat treaking smbios lines with ```dmidecode``` and [this guide](https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/). Also add there lines for ```scream``` and ```looking-glass``` from [this guide](https://alexbakker.me/post/nixos-pci-passthrough-qemu-vfio.html) into ```<devices> </devices>``` tag.

If you would like to use Spice to give you keyboard and mouse input along with clipboard sync support, make sure you have a ```<graphics type='spice'>``` device, then: find your ```<video>``` device, and set ```<model type='none'/>```. If you cannot find it, make sure you have a ```<graphics>``` device, save and edit again. Now you can start your VM and type ```looking-glass-client -F -S /dev/shm/looking-glass``` to start looking glass (it won't work if you would unplug video cable from you GPU). It there will no any video output refer to [this article](https://looking-glass.io/docs/B7/install_libvirt/#keyboard-mouse-display-audio).

### Theming
[sigma wallpaper pack](https://github.com/kotudemo/PoALFW/releases/tag/wallpapers) \
[Everforest theme](https://github.com/Serge2702/KDE-Everforest/blob/main/Everforest.colors) \
Tokyo Night theme isn't declared but you can get it via kde theme store 

#### Special thanks to...
[hand7s](https://github.com/s0me1newithhand7s)\
[MyNixOS](https://mynixos.com/) \
[NixOS Wiki](https://nixos.wiki/wiki/Main_Page)\
[NixOS Forum](https://discourse.nixos.org/)
