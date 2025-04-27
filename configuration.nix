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
      substituters = [
                # cache.nixos.org
                "https://nixos-cache-proxy.cofob.dev"
                "https://cache.nixos.org"
                # cache.garnix.org
                "https://cache.garnix.io"
                # cachix
                "https://nix-community.cachix.org/"
                "https://chaotic-nyx.cachix.org/"
                "https://ags.cachix.org"
                "https://hyprland.cachix.org"
                "https://chaotic-nyx.cachix.org/"
		"https://ezkea.cachix.org"
      ];
      trusted-public-keys = [
                # cache.nixos.org
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                # cache.garnix.io
                "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
                # cachix.org
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
                "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8="
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
		"ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      ];
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
      udpSupport = true;
      udpPorts = [
        "50000:50099"
        "443"
      ];
      params = [
        "--filter-udp=50000-50099"
        "--dpi-desync=fake"
        "--dpi-desync-any-protocol"
        "--new"
        "--filter-udp=443"
        "--dpi-desync-fake-quic=${self}/modules/shared/quic_initial_www_google_com.bin"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=2"
        "--new"
        "--filter-tcp=80,443"
        "--dpi-desync=fake,multidisorder"
        "--dpi-desync-ttl=3"
      ];
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

      ];
    };
  };
  
  environment = {
	systemPackages = with pkgs; [
	    	home-manager
	    	flatpak
		inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
            	chromium
            	firefox-devedition
            	obs-studio 
	    	mpv
		neovim
		amp
		micro
		kdePackages.kate
	    	kdePackages.kcalc
            	kdePackages.kcolorchooser
		inputs.freesm.packages.x86_64-linux.freesmlauncher
	    	heroic
            	tetrio-desktop
		zapret
	    	spoofdpi
	    	byedpi
	    	gparted
	    	gutenprint
	    	cups
	    	canon-cups-ufr2
	    	cups-filters
	    	nwg-look
	    	tokyonight-gtk-theme 
	    	xwayland
            	go
            	python3Full
		python.pkgs.pip
            	git
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
