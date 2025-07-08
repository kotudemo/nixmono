<p align="center">
  <img src="https://github.com/user-attachments/assets/47190ada-1cce-47b0-af1b-735f69200beb" alt="screenshot" width="600"/>
  <img src="https://github.com/user-attachments/assets/48dbd69d-9b99-4f30-b534-042ad434de6d" alt="screenshot" width="600"/>
</p>

<h1 align="center">🛠️ NixOS Config TODO List</h1>

### ✅ Planned Improvements
0. Stable commits???
1. Package UFR II printer driver via Flake
2. Package XP-Pen driver via Flake
3. Declare Spicetify extensions  
   ↳ Forking [Gerg-L's Spicetify flake](https://github.com/Gerg-L/spicetify-flake) to add marketplace support  
   OR 
   spicetify flatpak installation with spicetify install script
4. Declare [Vencord](https://github.com/KaylorBen/nixcord) extensions
5. Add `nixos-anywhere` and not `nixos-anywhere` installation guide
6. Refactor `passthrough.nix`
7. Manage Git and Zerotier secrets via SOPS and AgeNix
8. Add Docker configuration
9. Add some features from [Ampersand's configuration](https://github.com/Andrey0189/nixos-config-reborn)
10. Hardened specialisation
11. Custom boot manager skin 
12. Change file manager to yazi/superfile
13. Stylix \
    ↳ Automatic wallpaper change with stylix integration \
    ↳ Telegram theme generator \
    ↳ Change all theme colors to stylix colors \
14. To make custom module for home-manager to set `legcord` settings includidng app settings vencord, shelter, equicord plugins 
15. Fzf configuration  
16. Easy username changing by adding a variable
17. Helix more custom keybindings
18. flow-control tests
19. Hosts to separate flake with deleted github urls + better dns servers configuration with resolved
20. Vscodium home manager module
21. Change hyprexpo workspace_method and propely setup hypr-dynamic-cursors
22. Test fonts and cursors
23. Fix qt themes (again)
24. Fancy fastfetch config
25. Waybar \
    ↳ Language module \
    ↳ Weather module \
    ↳ Media module?
26. Swayimg mime types fix
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

### 🙏 Special Thanks

* [hand7s](https://github.com/s0me1newithhand7s)
* [MyNixOS](https://mynixos.com/)
* [NixOS Wiki](https://nixos.wiki/wiki/Main_Page)
* [NixOS Forum](https://discourse.nixos.org/)
