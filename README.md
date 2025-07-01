<p align="center">
  <img src="https://github.com/user-attachments/assets/f7ce3e4e-299b-444a-ace2-9106fdf6fb40" alt="screenshot" width="600"/>
  <img src="https://github.com/user-attachments/assets/4cfdc724-c451-4147-b885-fde028a74b38" alt="screenshot" width="600"/>
</p>

<h1 align="center">🛠️ NixOS Config TODO List</h1>

### ✅ Planned Improvements

1. Package UFR II printer driver via Flake
2. Package XP-Pen driver via Flake
3. Decalre chromium extensions  
4. Declare Spicetify extensions  
   ↳ Forking [Gerg-L's Spicetify flake](https://github.com/Gerg-L/spicetify-flake) to add marketplace support  
5. Declare [Vencord](https://github.com/KaylorBen/nixcord) extensions
6. Declare Flatpak applications
7. Integrate [Disko](https://github.com/nix-community/disko)
8. Add `nixos-anywhere` installation guide
9. Make `passthrough.nix` better via adding options to change PCI IDs definitions and enable AMD GPU and CPU support without need to change `passthrough.nix` 
10. Refactor everything into options for full customization
11. Fix clipboard history
12. Manage Git and Zerotier secrets via SOPS and AgeNix
13. Add Docker configuration
14. Fix hyprpanel config
16. Add some features from [Ampersand's configuration](https://github.com/Andrey0189/nixos-config-reborn)
17. Steal some plugins form hand7s Hyprland config 
18. Hardened specialisation
---

<h1 align="center">🎮 GPU Passthrough: Gaming on Windows VM</h1>

### ⚠️ Disclaimer

If your hardware is **low-end** (e.g., Intel i7-7700K or lower), ypu have no need to try, it's just better to dual-boot Windows 10.

For this guide you need:

- A CPU with iGPU (or second dGPU) for Linux host
- Setup with **Nvidia GTX 1000+** and **Intel CPU (10th gen or lower)** for this guide
- Otherwise, AMD GPU setups require modifying `passthrough.nix`

🧠 Useful links for custom setups:

- [NixOS Discourse thread](https://discourse.nixos.org/t/nixos-vfio-gpu-passthrough/41169/2)
- [Another one NixOS Discourse thread](https://discourse.nixos.org/t/single-gpu-passthrough/44119/2)
- [Techhazard's gist](https://gist.github.com/techhazard/1be07805081a4d7a51c527e452b87b26)
- [Arch Wiki: PCI Passthrough article](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Attaching_the_PCI_devices)
- [Some tips and tricks from Level1Techs Forum post](https://forum.level1techs.com/t/solved-help-with-dual-nvidia-gpu-and-looking-glass/190084/17)

---

### 📘 How-To Guide

1. **BIOS Setup**
   - Enable **iGPU**, **Virtualization**, and **Intel VT-d**
   - Plug monitor into motherboard (leave GPU connected as well)
   - Configure monitor input source

2. **NixOS Config**
   - Enable `passthrough` option in `configuration.nix`
   - Change `passthrough.nix`
   - Replace PCI IDs using:
     ```bash
     lspci -nn | grep -iE '(nvidia|amd)' # for GPU and Audio Controller PCI IDs 
     sudo lshw -c display # for NVIDIA Prime BUS IDs
     ```

3. **VM Setup**
   - Create a Windows VM using `virt-manager`
   - Install Windows + drivers for `looking-glass`, `spice`, `scream`
   - Reboot your pc
   - In virt-manager, go to **Add Hardware → PCI Host Device**
     - Add GPU and Audio Controller
   - Edit VM `.xml`:
     - Add spoofed `smbios` data with `dmidecode`
     - Use [Astrid's Guide](https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/)
     - Add `<devices>` entries for `scream` and `looking-glass`: [Guide](https://alexbakker.me/post/nixos-pci-passthrough-qemu-vfio.html)
     - Enable SPICE Input + Clipboard Sync
       - Ensure `<graphics type='spice'>` exists
       - Find `<video>` and set:
         ```xml
         <model type='none'/>
         ```



4. **Start VM + Looking Glass**
   ```bash
   looking-glass-client -F -S /dev/shm/looking-glass
   ```

📌 *Ensure GPU is connected to your monitor or create a virtual monitor*

🔧 Troubleshooting: [Looking Glass Setup](https://looking-glass.io/docs/B7/install_libvirt/#keyboard-mouse-display-audio)

---

### 🎨 Theming & Appearance

* [Sigma Wallpapers](https://github.com/kotudemo/PoALFW/releases/tag/wallpapers)
* [Everforest KDE Theme](https://github.com/Serge2702/KDE-Everforest/blob/main/Everforest.colors)
* Tokyo Night theme: available in KDE store

---

### 🙏 Special Thanks

* [hand7s](https://github.com/s0me1newithhand7s)
* [MyNixOS](https://mynixos.com/)
* [NixOS Wiki](https://nixos.wiki/wiki/Main_Page)
* [NixOS Forum](https://discourse.nixos.org/)
