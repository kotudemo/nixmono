{
  config,
  pkgs,
  lib,
  inputs,
  self,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/options/modules.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.aagl.nixosModules.default
  ];

  #quickSettings = {
  # enable = true;
  passthrough.enable = false;
  zapret.enable = true;
  # };

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelModules = [
      "kvm-intel"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
      "v4l2loopback"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback nr_devices=2 exclusive_caps=1,1 video_nr=0,1 card_label=v4l2lo0,v4l2lo1
    '';
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
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [];
      supportedFilesystems = [
        "ntfs"
        "refs"
      ];
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 100;
    memoryPercent = 100;
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
    opentabletdriver.enable = true;
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
    firewall = {
      # firewall options
      allowPing = false; # you can restrict ping to your host in case you'll need
      enable = true; # toggle for enabling firewall
    };
    networkmanager = {
      enable = true;
    };
    wireless = {
      enable = false;
    };
    timeServers = [
      # https://wiki.nixos.org/wiki/NTP
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
      adminIdentities = [
        "unix-group:wheel"
      ];
    };
    sudo = {
      enable = lib.mkDefault false;
    };
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = true;
      execWheelOnly = true;
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
      miracode
      monocraft
      nerd-fonts.agave
      nerd-fonts.anonymice
      nerd-fonts.arimo
      nerd-fonts.blex-mono
      nerd-fonts.bigblue-terminal
      nerd-fonts.bitstream-vera-sans-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.caskaydia-mono
      nerd-fonts.daddy-time-mono
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.droid-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.go-mono
      nerd-fonts.gohufont
      nerd-fonts.hack
      nerd-fonts.im-writing
      nerd-fonts.inconsolata
      nerd-fonts.inconsolata-go
      nerd-fonts.inconsolata-lgc
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.iosevka-term-slab
      nerd-fonts.jetbrains-mono
      nerd-fonts.roboto-mono
      nerd-fonts.shure-tech-mono
      nerd-fonts.sauce-code-pro
      nerd-fonts.terminess-ttf
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-sans
      nerd-fonts.ubuntu-mono
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
    flatpak.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    pulseaudio.enable = false;
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
      videoDrivers = [
        "nvidia"
      ];
      xkb = {
        layout = "us,ru";
        options = "grp:shift_alt_toggle";
      };
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        canon-cups-ufr2
        gutenprintBin
      ];
      listenAddresses = [
        "localhost:631"
      ];
      openFirewall = true;
      webInterface = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig = {
        pipewire = {
          "92-low-latency" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.allowed-rates" = [
                44100
                48000
                88200
                96000
              ];

              "default.clock.min-quantum" = 512;
              "default.clock.quantum" = 4096;
              "default.clock.max-quantum" = 8192;
            };
          };

          "93-no-resampling" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.allowed-rates" = [
                44100
                48000
                96000
                192000
              ];
            };
          };

          "94-no-upmixing" = {
            "stream.properties" = {
              "channelmix.upmix" = false;
            };
          };
        };
      };
    };

    scx = {
      enable = true;
      package = pkgs.scx_git.full;
      scheduler = "scx_lavd";
    };

    zerotierone = {
      enable = true;
      joinNetworks = [
      ];
    };

    /*
      zapret = {
      enable = true;
      udpSupport = true;
      udpPorts = [
        "50000:50099"
        "443"
      ];
      params = [
        "--filter-tcp=80"
        "--dpi-desync=fake,split2"
        "--dpi-desync-autottl=2"
        "--dpi-desync-fooling=md5sig"
        "--new"

        "--filter-tcp=443"
        "--dpi-desync=fake,split2"
        "--dpi-desync-repeats=11"
        "--dpi-desync-fooling=md5sig"
        "--dpi-desync-fake-tls=${inputs.secret_files.packages.${pkgs.system}.files}/tls_clienthello_www_google_com.bin"
        "--new"

        "--filter-tcp=80,443"
        "--dpi-desync=fake,disorder2"
        "--dpi-desync-autottl=2"
        "--dpi-desync-fooling=md5sig"
        "--new"

        "--filter-udp=50000-50099"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=6"
        "--dpi-desync-any-protocol"
        "--dpi-desync-cutoff=n4"
        "--new"
        "--filter-udp=443"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=11"
        "--dpi-desync-fake-quic=${inputs.secret_files.packages.${pkgs.system}.files}/quic_initial_www_google_com.bin"
        "--new"

        "--filter-udp=443"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=11"
        "--new"
      ];
    };
    */
  };

  users = {
    #defaultUserShell = pkgs.fish;
    mutableUsers = true;
    users.kd = {
      isNormalUser = true;
      description = "GOIDALIZATOR777";
      extraGroups = [
        "networkmanager"
        "input"
        "wheel"
        "disk"
        "audio"
        "video"
        "dialout"
        "adbusers"
      ];
      initialPassword = "password";
      shell = pkgs.fish;
      packages = with pkgs; [
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      home-manager

      # Everyday software
      vesktop
      materialgram
      cromite
      firefox-devedition
      spicetify-cli
      mpv
      libreoffice-qt6-fresh
      kdePackages.kcalc
      lmstudio

      # Text editors
      neovim
      amp
      micro
      evil-helix_git
      kdePackages.kate

      # Gaming
      inputs.freesm.packages.${pkgs.system}.freesmlauncher
      heroic
      lutris
      legendary-heroic
      bottles

      # Theming
      nwg-look
      tokyonight-gtk-theme
      everforest-gtk-theme

      # Networking
      protonvpn-gui
      inputs.secret_files.packages.${pkgs.system}.files

      # Essential
      nvtopPackages.full
      wget
      git
      gh
      p7zip-rar
      fastfetch
      ntfs3g
      gparted
      xwayland
      go
      python3Full
      python.pkgs.pip
      #obs
      v4l-utils
      obs-studio
    ];
    shellAliases =
      # global aliases
      let
        flakeDir = "/etc/nixos";
      in {
        cl = "clear";
        ls = "eza -al --color=always --group-directories-first --icons"; # preferred listing
        la = "eza -a --color=always --group-directories-first --icons"; # all files and dirs
        ll = "eza -l --color=always --group-directories-first --icons"; # long format
        lt = "eza -aT --color=always --group-directories-first --icons"; # tree listing
        lsdot = "eza -a | grep -e '^\.'"; # show only dotfiles
        please = "sudo";
        jctl = "journalctl -p 3 -xb";
        sv = "sudo nvim";
        v = "nvim";
        vi = "nvim";
        vim = "nvim";
        nv = "nvim";
        nvim = "nvim";
        nsp = "nix-shell -p";
        ncg = "nh clean all --keep 3 --keep-since 1d";
        upd = "sudo nix-channel --update nixos && sudo nixos-rebuild switch --upgrade-all --flake ${flakeDir}";

        fmt = "sudo nix run flake:nixpkgs#alejandra";
        btop = "nix run flake:nixpkgs#btop";
        pf = "clear && nix run flake:nixpkgs#pfetch";
        ff = "clear && nix run flake:nixpkgs#fastfetch";
        nf = "clear && nix run flake:nixpkgs#neofetch";
        #hms = "home-manager switch --flake ${flakeDir}"; for home configurations
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
        fastfetch
      '';
    };
    java = {
      enable = true;
      package = pkgs.jdk24;
    };
    honkers-railway-launcher.enable = true;
    amnezia-vpn.enable = true;
    adb.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    users.kd = {
      config,
      pkgs,
      options,
      inputs,
      ...
    }: {
      imports = [
        ./modules/hmdir/modules.nix
      ];

      home = {
        username = "kd";
        homeDirectory = "/home/kd";
        stateVersion = "25.11";
        packages = with pkgs; [
          blesh
        ];
      };
    };
  };

  system = {
    stateVersion = "25.11";
    name = lib.mkDefault "nixos";
  };
}
