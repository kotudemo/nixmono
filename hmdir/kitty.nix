{
    ...
}: {
    programs = {
		kitty = {
            enable = true;                  # enabling toggle
            settings = {
                confirm_os_window_close = 0;
            };
            shellIntegration = {
                enableBashIntegration = true;   # integration with bash
                enableFishIntegration = true;   # integration with fish
                enableZshIntegration = true;
            };
            themeFile = "tokyo_night_night";
            font = {
                #name = "Inconsolata LGC for Powerline";
                name = "Roboto Mono Nerd Font SemiBold";
                size = 11;
            };
		};
    };
}
