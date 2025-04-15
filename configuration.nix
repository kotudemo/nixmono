{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.aagl.nixosModules.default
    ];

   boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelModules = [ "kvm-intel" "nvidia" ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        memtest86 = {   
          enable = true;
          sortKey = "o_memtest86";
        };
        netbootxyz = {                  
          enable = false;
          sortKey = "o_netbootxyz";
        };
        sortKey = "nixos";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
      supportedFilesystems = [ "ntfs" "refs" ];
    };
  };

  nix = {
  package = pkgs.nixFlakes;
    settings = {
      allowed-users = [
        "kd"
        "root"
      ];
      trusted-users = [
        "kd"
        "root"
      ];
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      substituters = [ "https://ezkea.cachix.org" ];
      trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [
        "python-2.7.18.8"
      ];
    };
    hostPlatform = lib.mkDefault "x86_64-linux";
  };


  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    pulseaudio.enable = false;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      datacenter.enable = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
    };
  };

  networking = {
    hostName = "nixos";
    useDHCP = lib.mkDefault true;
    interfaces.eno1.useDHCP = lib.mkDefault true;
    firewall = {                            # firewall options
      allowPing = false;                   # you can restrict ping to your host in case you'll need
      enable = true;                      # toggle for enabling firewall
    };
    networkmanager = {
      enable = true;
    };
    wireless = {
      enable = false;
    };
    timeServers = [                         # https://wiki.nixos.org/wiki/NTP
      "0.nixos.pool.ntp.org"
      "1.nixos.pool.ntp.org"
      "2.nixos.pool.ntp.org"
      "3.nixos.pool.ntp.org"
    ];
  };

  security = {
    rtkit = {
      enable = true;
    };
    polkit = {
      enable = true;
    };
  };

  time.timeZone = "Europe/Samara";

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      twemoji-color-font
      jetbrains-mono
      powerline-fonts
      powerline-symbols
      nerdfonts
      miracode
      monocraft
    ];
  };

    i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  console = {
    enable = true;
    keyMap = "us";
    useXkbConfig = false;
  };

  services = {
    fstrim.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    displayManager = {
      sddm = {
        enable = true;
      };
    };
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
    xserver = {
    enable = true;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us,ru";
        variant = "qwerty";
        options = "grp:shift_alt_toggle";
      };
    };
    printing = {
      enable = true;
      drivers = with pkgs; [ canon-cups-ufr2 cups-filters gutenprint ];
      listenAddresses = [
        "localhost:631"
      ];
      openFirewall = true;
      webInterface = true;
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
     zapret = {
       enable = true;
       config = ''
         MODE="tpws"
         FWTYPE="iptables"
         MODE_HTTP=1
         MODE_HTTP_KEEPALIVE=0
         MODE_HTTPS=1
         MODE_QUIC=1
         QUIC_PORTS=50000-65535
         MODE_FILTER=none
         DISABLE_IPV6=1
         INIT_APPLY_FW=1
         TPWS_OPT="--dpi-desync=syndata,fake,split2 --dpi-desync-split-seqovl=336 --dpi-desync-fooling=md5sig --dpi-desync-split-seqovl-pattern=/nix/store/nzrvw5f5c4l8j1svhwsz9fxcw0qfvs2r-zapret-/src/files/fake/tls_clienthello_iana_org.bin --split-pos=1 --oob --mss=88 --bind-addr=127.0.0.1 --port=8081 --uid=1:3003 --socks"
       '';
     };
  };

  users = {
    defaultUserShell = pkgs.fish;
	mutableUsers = true;
    users.kd = {
      isNormalUser = true;
      description = "GOIDALIZATOR777";
      extraGroups = [ "networkmanager" "input ""wheel" ];
      initialPassword = "password";
      packages = with pkgs; [
        kdePackages.kcalc
        kdePackages.kate
        kdePackages.kcolorchooser
        materialgram
      ];
    };
  };
  
	 environment = {
        systemPackages = with pkgs; [
            chromium
            firefox-devedition
            pkgs.gnome.epiphany
			xwayland
			vlc
			heroic
			tetrio-desktop
			spoofdpi
			byedpi
			nwg-look
			tokyonight-gtk-theme
			flatpak
			home-manager
	        obs-studio
	        gparted
	        gutenprint
	        cups
	        canon-cups-ufr2
			cups-filters
            go
            python3Full
            git
            nodejs
            python.pkgs.pip
            gcc
            gnumake
            jq
            libxml2
            libjpeg
            libstdcxx5
            fishPlugins.z
            fishPlugins.plugin-git
            fishPlugins.puffer
            ];
        shellAliases =                             # global aliases
            let
                flakeDir = "/etc/nixos";
            in {
                cl = "clear";
                ls="eza -al --color=always --group-directories-first --icons"; # preferred listing
				la="eza -a --color=always --group-directories-first --icons";  # all files and dirs
				ll="eza -l --color=always --group-directories-first --icons";  # long format
				lt="eza -aT --color=always --group-directories-first --icons"; # tree listing
				lsdot="eza -a | grep -e '^\.'";       # show only dotfiles
				please="sudo";
				jctl="journalctl -p 3 -xb";
      	        pf = "clear && nix run nixpkgs#pfetch";
	            ff = "clear && nix run nixpkgs#fastfetch";
	            nf = "clear && nix run nixpkgs#neofetch";
                unzip = "nix run nixpkgs#unzip -- ";
                unrar = "nix run nixpkgs#unrar -- ";
                zip = "nix run nixpkgs#zip -- ";
                sv = "sudo nvim";
                v = "nvim";
                vi = "nvim";
                vim = "nvim";
                nv = "nvim";
                nvim = "nvim";
	            btop = "clear && nix run nixpkgs#btop";
	            nsp = "nix-shell -p";
	            ncg = "nix store gc -v && nix-collect-garbage --delete-old";
	            upd = "sudo nix-channel --update nixos && sudo nixos-rebuild switch --upgrade-all --flake ${flakeDir}";
                hms = "home-manager switch --flake ${flakeDir}";
        };
     };

  programs = {
    steam = {
      enable = true;
      remotePlay = {
        openFirewall = true;
      };
      gamescopeSession = {
        enable = true;
      };
    };
    gamemode = {
      enable = true;
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        starship init fish | source
      '';
    };
    the-honkers-railway-launcher.enable = true;
  };

  home-manager = {
    users.kd = { config, pkgs, options, inputs,  ...}: {
      imports = [
		./hmdir/modules.nix
      ];

      home = {
        username = "kd";
        homeDirectory = "/home/kd";
        stateVersion = "24.11";
        packages = with pkgs; [

        ];
      };
    };
  };

 chaotic = {
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
 };

  system = {
    stateVersion = "24.11";
    name = lib.mkDefault "nixos";
  };
}
