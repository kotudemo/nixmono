{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [ 
        "title"
        "separator"
        "os"
        # "host"
        "kernel"
        "uptime"
        "packages"
        "de"
        "wm"
        "shell"
        # "display"
        # "wmtheme"
        # "theme"
        # "icons"
        # "font"
        # "cursor"
        # "terminal"
        # "terminalfont"
        "cpu"
        "gpu"
        "memory"
        # "swap"
        "disk"
        # "localip"
        # "battery"
        # "poweradapter"
        # "locale"
        "break"
        "colors"
      ];
    };
  };
}