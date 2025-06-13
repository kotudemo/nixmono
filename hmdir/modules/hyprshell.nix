{ inputs, ... } : {
  imports = [
    inputs.hyprshell.homeModules.hyprshell
  ];
  programs.hyprshell = {
    enable = true;
    systemd.args = "-v";
    settings = {
    #  launcher = {
    #    max_items = 6;
    #    plugins.websearch = {
    #        enable = true;
    #        engines = [{
    #            name = "DuckDuckGo";
    #            url = "https://duckduckgo.com/?q=%s";
    #            key = "d";
    #        }];
    #    };
    #  };
      window.switch = {
        enable = true;
        open = {
          modifier = "alt"
        };
        navigate = {
          forward = "tab";
          reverse = {
            key = "tab";
            mod = "shift";
          };
        };
      };
}