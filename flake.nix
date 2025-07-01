{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };

    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };

    freesm = {
      url = "github:FreesmTeam/FreesmLauncher";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zapret-presets = {
      url = "github:kotudemo/zapret-presets";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
    };
    hyprshell = {
      url = "github:H3rmt/hyprswitch?ref=hyprshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixgl,
    nur,
    chaotic,
    freesm,
    spicetify-nix,
    disko,
    nixos-anywhere,
    stylix,
    zapret-presets,
    nixcord,
    hyprshell,
    aagl,
    nix-flatpak,
    ...
  } @ inputs: let
    cfgDir = "~/sigmaNix";
  in {
    homeConfigurations."kd@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs self cfgDir;};
      modules = [
        ./hmdir/home.nix
        inputs.stylix.homeModules.stylix
        inputs.chaotic.homeManagerModules.default
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
        inputs.nur.modules.homeManager.default
      ];
    };

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs self;
        };
        modules = [
          (
            {
              config,
              pkgs,
              lib,
              inputs,
              modulesPath,
              ...
            }: {
              imports = [
                # Include the results of the hardware scan.
                (modulesPath + "/installer/scan/not-detected.nix")
                inputs.aagl.nixosModules.default
                ./options/modules.nix
              ];

              games.enable = true;
              passthrough.enable = false;

              fileSystems."/" = {
                device = "/dev/disk/by-uuid/fe8cfb14-50a2-4ab4-befa-904db1384b34";
                fsType = "btrfs";
                options = ["subvol=@"];
              };

              fileSystems."/boot" = {
                device = "/dev/disk/by-uuid/6CCC-CCD9";
                fsType = "vfat";
                options = ["fmask=0077" "dmask=0077"];
              };
              /*
                fileSystems."/" = {
                device = "/dev/disk/by-label/root";
                fsType = "btrfs";
              };

              fileSystems."/boot" = {
                device = "/dev/disk/by-label/BOOT";
                fsType = "vfat";
                options = ["fmask=0077" "dmask=0077"];
              };
              */

              boot = {
                kernelPackages = pkgs.linuxPackages_cachyos;
                #kernelPackages = pkgs.linuxPackages_zen;
                #kernelPackages = pkgs.linuxPackages_xanmod;
                kernelModules = [
                  "kvm-intel"
                  "amdgpu"
                ];
                extraModulePackages = with config.boot.kernelPackages; [
                ];
                blacklistedKernelModules = [
                  "k10temp"
                  "ax25"
                  "netrom"
                  "rose"
                  "adfs"
                  "affs"
                  "bfs"
                  "befs"
                  "cramfs"
                  "efs"
                  "erofs"
                  "exofs"
                  "freevxfs"
                  "hfs"
                  "hpfs"
                  "jfs"
                  "minix"
                  "omfs"
                  "qnx4"
                  "qnx6"
                  "sysv"
                  "sp5100-tco"
                  "iTCO_wdt"
                ];
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

              systemd = {
                oomd = {
                  enable = true;
                  enableUserSlices = true;
                  enableSystemSlice = true;
                  enableRootSlice = true;
                };
                slices = {
                  root = {
                    sliceConfig = {
                      ManagedOOMSwap = "kill";
                      ManagedOOMMemoryPressure = "kill";
                      ManagedOOMMemoryPressureLimit = "40%";
                      ManagedOOMMemoryPressureDurationSec = 0;
                    };
                  };
                  system = {
                    sliceConfig = {
                      ManagedOOMSwap = "kill";
                      ManagedOOMMemoryPressure = "kill";
                      ManagedOOMMemoryPressureLimit = "40%";
                      ManagedOOMMemoryPressureDurationSec = 0;
                    };
                  };
                  user = {
                    sliceConfig = {
                      ManagedOOMSwap = "kill";
                      ManagedOOMMemoryPressure = "kill";
                      ManagedOOMMemoryPressureLimit = "40%";
                      ManagedOOMMemoryPressureDurationSec = 0;
                    };
                  };
                };
              };

              zramSwap = {
                enable = true;
                algorithm = "zstd";
                priority = 100;
                memoryPercent = 100;
              };

              nix = {
                package = pkgs.nixVersions.latest;
                settings = {
                  auto-optimise-store = true;
                  allowed-users = [
                    "@wheel"
                  ];
                  trusted-users = [
                    "@wheel"
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
                    # ezkea
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
                    # ezkea
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
                overlays = [
                ];
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
                amdgpu = {
                  initrd = {
                    enable = true;
                  };
                };
              };

              networking = {
                hostName = "nixos";
                useDHCP = lib.mkDefault true;
                dhcpcd = {
                  enable = true;
                  persistent = false;
                  wait = "any";
                };
                firewall = {
                  # firewall options
                  allowPing = true; # you can restrict ping to your host in case you'll need
                  enable = true; # toggle for enabling firewall
                };
                networkmanager = {
                  enable = true;
                  dns = "systemd-resolved";
                  dhcp = "internal";
                };
                wireless = {
                  enable = false;
                };
                extraHosts = ''
                  ### t.me/immalware: hosts file
                  # Последнее обновление: 26 июня 2025
                  # hosts по этой ссылке неактуален и больше не будет обновляться!
                  # Актуальный hosts тут: github.com/ImMALWARE/textbin/blob/main/hosts
                  # Дополнение к zapret:
                  157.240.245.174 instagram.com
                  157.240.245.174 www.instagram.com
                  157.240.245.174 b.i.instagram.com
                  157.240.245.174 z-p42-chat-e2ee-ig.facebook.com
                  157.240.245.174 help.instagram.com
                  3.66.189.153 protonmail.com
                  3.66.189.153 mail.proton.me
                  64.233.164.198 yt3.ggpht.com
                  52.223.13.41 tracker.openbittorrent.com

                  # ChatGPT, OpenAI:
                  204.12.192.222 chatgpt.com
                  204.12.192.222 ab.chatgpt.com
                  204.12.192.222 auth.openai.com
                  204.12.192.222 auth0.openai.com
                  204.12.192.222 platform.openai.com
                  204.12.192.222 cdn.oaistatic.com
                  204.12.192.222 files.oaiusercontent.com
                  204.12.192.222 cdn.auth0.com
                  204.12.192.222 tcr9i.chat.openai.com
                  204.12.192.222 webrtc.chatgpt.com
                  204.12.192.219 android.chat.openai.com
                  204.12.192.222 api.openai.com
                  204.12.192.221 operator.chatgpt.com
                  204.12.192.222 sora.chatgpt.com

                  # Сервисы Google:
                  204.12.192.222 gemini.google.com
                  204.12.192.222 aistudio.google.com
                  204.12.192.222 generativelanguage.googleapis.com
                  204.12.192.222 aitestkitchen.withgoogle.com
                  204.12.192.219 aisandbox-pa.googleapis.com
                  204.12.192.222 webchannel-alkalimakersuite-pa.clients6.google.com
                  204.12.192.221 alkalimakersuite-pa.clients6.google.com
                  204.12.192.221 assistant-s3-pa.googleapis.com
                  204.12.192.222 proactivebackend-pa.googleapis.com
                  204.12.192.222 o.pki.goog
                  204.12.192.222 labs.google
                  204.12.192.222 notebooklm.google
                  204.12.192.222 notebooklm.google.com
                  204.12.192.222 jules.google.com
                  204.12.192.222 stitch.withgoogle.com

                  # Microsoft Copilot, Microsoft Rewards, Xbox, Xbox Cloud Gaming:
                  204.12.192.222 copilot.microsoft.com
                  204.12.192.222 sydney.bing.com
                  204.12.192.222 edgeservices.bing.com
                  204.12.192.221 rewards.bing.com
                  78.40.217.193 xsts.auth.xboxlive.com
                  50.7.87.86 xgpuwebf2p.gssv-play-prod.xboxlive.com
                  50.7.87.86 xgpuweb.gssv-play-prod.xboxlive.com

                  # Spotify:
                  204.12.192.222 api.spotify.com
                  204.12.192.222 xpui.app.spotify.com
                  204.12.192.222 appresolve.spotify.com
                  204.12.192.222 login5.spotify.com
                  204.12.192.222 login.app.spotify.com
                  204.12.192.222 encore.scdn.co
                  204.12.192.222 ap-gew1.spotify.com
                  204.12.192.222 gew1-spclient.spotify.com
                  204.12.192.222 spclient.wg.spotify.com
                  204.12.192.222 api-partner.spotify.com
                  204.12.192.222 aet.spotify.com
                  204.12.192.222 www.spotify.com
                  204.12.192.222 accounts.spotify.com
                  204.12.192.221 open.spotify.com

                  # GitHub Copilot:
                  50.7.87.84 api.github.com
                  204.12.192.222 api.individual.githubcopilot.com
                  204.12.192.222 proxy.individual.githubcopilot.com

                  # JetBrains:
                  50.7.85.221 datalore.jetbrains.com
                  107.150.34.100 plugins.jetbrains.com
                  204.12.192.222 download.jetbrains.com

                  # ElevenLabs:
                  204.12.192.222 elevenlabs.io
                  204.12.192.222 api.us.elevenlabs.io
                  204.12.192.222 elevenreader.io
                  204.12.192.222 api.elevenlabs.io
                  204.12.192.222 help.elevenlabs.io

                  # Truth Social
                  204.12.192.221 truthsocial.com
                  204.12.192.221 static-assets-1.truthsocial.com

                  # Grok
                  204.12.192.222 grok.com
                  204.12.192.222 accounts.x.ai
                  204.12.192.222 assets.grok.com

                  # Tidal
                  204.12.192.222 api.tidal.com
                  204.12.192.222 listen.tidal.com
                  204.12.192.222 login.tidal.com
                  204.12.192.222 auth.tidal.com
                  204.12.192.222 link.tidal.com
                  204.12.192.222 dd.tidal.com
                  204.12.192.222 resources.tidal.com
                  204.12.192.221 images.tidal.com
                  204.12.192.222 fsu.fa.tidal.com
                  204.12.192.222 geolocation.onetrust.com
                  204.12.192.222 api.squareup.com
                  204.12.192.222 api-global.squareup.com

                  # Clash Royale, Clash of Clans, Brawl Stars
                  3.160.212.81 cdn.id.supercell.com
                  18.172.112.81 security.id.supercell.com
                  3.165.113.14 accounts.supercell.com
                  18.66.195.96 game-assets.clashroyaleapp.com
                  51.158.190.98 game.clashroyaleapp.com
                  3.162.38.39 game-assets.clashofclans.com
                  70.34.251.56 gamea.clashofclans.com
                  108.157.194.81 clashofclans.inbox.supercell.com
                  179.43.168.109 game.brawlstarsgame.com
                  18.239.69.129 game-assets.brawlstarsgame.com

                  # DeepL
                  204.12.192.222 deepl.com
                  204.12.192.222 www.deepl.com
                  204.12.192.222 www2.deepl.com
                  204.12.192.222 login-wall.deepl.com
                  204.12.192.219 w.deepl.com
                  204.12.192.222 s.deepl.com
                  204.12.192.222 dict.deepl.com
                  204.12.192.222 ita-free.www.deepl.com
                  204.12.192.222 write-free.www.deepl.com
                  204.12.192.222 experimentation.deepl.com

                  # Deezer
                  204.12.192.220 deezer.com
                  204.12.192.220 www.deezer.com
                  204.12.192.220 dzcdn.net
                  204.12.192.220 payment.deezer.com

                  # Weather.com
                  204.12.192.220 weather.com
                  204.12.192.220 upsx.weather.com

                  # Guilded
                  204.12.192.219 guilded.gg
                  204.12.192.219 www.guilded.gg

                  # Twitch
                  204.12.192.219 usher.ttvnw.net
                  204.12.192.219 gql.twitch.tv

                  # Fitbit
                  204.12.192.219 api.fitbit.com
                  204.12.192.219 fitbit-pa.googleapis.com
                  204.12.192.219 fitbitvestibuleshim-pa.googleapis.com
                  204.12.192.219 fitbit.google.com

                  # Другое:
                  204.12.192.222 claude.ai
                  204.12.192.220 console.anthropic.com
                  204.12.192.222 www.notion.so
                  50.7.85.222 www.canva.com
                  204.12.192.222 www.intel.com
                  204.12.192.219 www.dell.com
                  50.7.85.219 www.tiktok.com # Только на сайте. Приложение определяет регион по оператору, а не по IP. Поэтому есть моды.
                  142.54.189.106 web.archive.org # Блокирует от российских IP некоторые сайты
                  204.12.192.220 developer.nvidia.com
                  107.150.34.99 builds.parsec.app
                  204.12.192.220 tria.ge
                  204.12.192.220 api.imgur.com

                  # Блокировка реально плохих сайтов
                  # Скримеры:
                  0.0.0.0 only-fans.uk
                  0.0.0.0 only-fans.me
                  0.0.0.0 onlyfans.wtf
                  # IP Logger'ы:
                  0.0.0.0 iplogger.org
                  0.0.0.0 wl.gl
                  0.0.0.0 ed.tc
                  0.0.0.0 bc.ax
                  0.0.0.0 maper.info
                  0.0.0.0 2no.co
                  0.0.0.0 yip.su
                  0.0.0.0 iplis.ru
                  0.0.0.0 ezstat.ru
                  0.0.0.0 iplog.co
                  0.0.0.0 grabify.org
                '';
                nameservers = [
                  "1.1.1.1"
                  "1.0.0.1"
                  "8.8.8.8"
                  "8.8.4.4"
                  "2606:4700:4700::1111"
                  "2606:4700:4700::1001"
                  "2001:4860:4860::8888"
                  "2001:4860:4860::8844"
                ];
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
                  powerline-fonts
                  powerline-symbols
                  miracode
                  monocraft
                  nerd-fonts.agave
                  nerd-fonts.blex-mono
                  nerd-fonts.bigblue-terminal
                  nerd-fonts.caskaydia-cove
                  nerd-fonts.caskaydia-mono
                  nerd-fonts.fantasque-sans-mono
                  nerd-fonts.fira-code
                  nerd-fonts.fira-mono
                  nerd-fonts.gohufont
                  nerd-fonts.hack
                  nerd-fonts.im-writing
                  nerd-fonts.jetbrains-mono
                  nerd-fonts.mononoki
                  nerd-fonts.roboto-mono
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
                tumbler.enable = true;
                pulseaudio.enable = false;

                zapret = {
                  enable = true;
                  sf_presets = {
                    enable = true;
                    preset = "general";
                  };
                };

                ananicy = {
                  enable = true;
                  package = pkgs.ananicy-cpp;
                  rulesProvider = pkgs.ananicy-rules-cachyos;
                };

                greetd = {
                  enable = true;
                  vt = 7;
                  restart = false;
                  settings = {
                    default_session = {
                      command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r -t -c Hyprland --greet-align center";
                      user = "greeter";
                    };
                  };
                };

                xserver = {
                  enable = true;
                  videoDrivers = [
                    "amdgpu"
                  ];
                  xkb = {
                    layout = "us,ru";
                    options = "grp:alt_shift_toggle";
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
                  alsa = {
                    enable = true;
                    support32Bit = true;
                  };

                  audio = {
                    enable = true;
                  };

                  pulse = {
                    enable = true;
                  };

                  jack = {
                    enable = true;
                  };

                  wireplumber = {
                    enable = true;
                  };
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
                  fishPlugins.autopair
                  home-manager
                  ripgrep-all
                  tealdeer
                  comma
                  git
                  gh
                  p7zip-rar
                  nvtopPackages.full
                  python3Full
                  python.pkgs.pip
                  xdg-utils
                ];
                shellAliases = {
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
                  upd = "sudo nix-channel --update nixos && sudo nixos-rebuild switch --upgrade-all --flake ${cfgDir}";
                  hms = "rm -rf ${config.users.users.kd.home}/.gtkrc-2.0 ${config.users.users.kd.home}/.config/fontconfig/conf.d/10-hm-fonts.conf ${config.users.users.kd.home}/.config/qt6ct/qt6ct.conf && , home-manager switch --flake ${cfgDir}"; #for home configurations
                  gtu = "git add ./* && git commit -a --allow-empty-message -m '' && git push -u origin HEAD";
                  ff = "fastfetch";
                  cd = "z";
                  cdd = "zi";

                  j2n = "nix run github:sempruijs/json2nix";
                  tokei = ", tokei";
                  fmt = ", alejandra";

                  gping = ", gping";
                  trip = ", trip";

                  xh = ", xh";
                  yt = ", yt-dlp";
                  nurl = ", nurl";
                  nom = ", nom";

                  sed = ", sd";
                  du = ", dust";
                  ps = ", procs";
                  top = ", btm";
                  pf = ", pfetch";
                };
              };

              xdg = {
                icons = {
                  enable = true;
                };
                portal = {
                  enable = true;

                  config = {
                    common = {
                      default = [
                        "gtk"
                      ];
                    };

                    hyprland = {
                      preferred = [
                        "gtk"
                        "hyprland"
                      ];
                    };

                    sway = {
                      preferred = [
                        "gtk"
                        "wlr"
                      ];
                    };
                  };

                  extraPortals = with pkgs; [
                    xdg-desktop-portal-gtk
                    xdg-desktop-portal-wlr
                    xdg-desktop-portal-hyprland
                  ];
                };

                mime = {
                  enable = true;
                  defaultApplications = {
                    "x-scheme-handler/http" = "chromium.desktop";
                    "x-scheme-handler/https" = "chromium.desktop";
                    "x-scheme-handler/chrome" = "chromium.desktop";
                    "text/*" = "text.desktop";
                    "application/x-shellscript" = "text.desktop";
                    "application/octet-stream" = "text.desktop";
                    "image/*" = "swayimg.desktop";
                    "video/*" = "mpv.desktop";
                    "audio/*" = "mpv.desktop";
                    "x-scheme-handler/magnet" = "qbittorrent.desktop";
                    "application/x-bittorrent" = "qbittorrent.desktop";
                    "x-scheme-handler/mailto" = "mail.desktop";
                    "application/postscript" = "pdf.desktop";
                    "application/pdf" = "pdf.desktop";
                    "application/rss+xml" = "rss.desktop";
                    "inode/directory" = "thunar.desktop";
                    "text/html" = "chromium.desktop";
                    "application/x-extension-htm" = "chromium.desktop";
                    "application/x-extension-html" = "chromium.desktop";
                    "application/x-extension-shtml" = "chromium.desktop";
                    "application/xhtml+xml" = "chromium.desktop";
                    "application/x-extension-xhtml" = "chromium.desktop";
                    "application/x-extension-xht" = "chromium.desktop";
                  };
                };
              };

              programs = {
                fish = {
                  enable = true;
                  interactiveShellInit = ''
                    set fish_greeting # Disable greeting
                    starship init fish | source
                    zoxide init fish | source
                    fastfetch
                  '';
                };
                java = {
                  enable = true;
                  package = pkgs.jdk24;
                };
                thunar = {
                  enable = true;
                  plugins = with pkgs.xfce; [
                    thunar-archive-plugin
                    thunar-volman
                    thunar-vcs-plugin
                    thunar-media-tags-plugin
                  ];
                };
                xfconf.enable = true;
                nix-index-database.comma.enable = true;
                amnezia-vpn.enable = true;
                adb.enable = true;
                dconf.enable = true;
              };

              system = {
                stateVersion = config.system.nixos.release;
                name = config.networking.hostName;
              };
            }
          )
          inputs.chaotic.nixosModules.default
          inputs.nix-index-database.nixosModules.nix-index
          inputs.zapret-presets.nixosModules.presets
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
