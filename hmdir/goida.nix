{
  pkgs,
  lib,
  inputs,
  ...
}: {
    wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        package = pkgs.hyprland;

        settings = {
            bind = [
                "SUPER ALT CTRL, D, exec, /home/kd/gits/degoidalizator.sh"
                "SUPER ALT CTRL, G, exec, /home/kd/gits/goidalizator.sh" 
            ];
        };
      };
    };
    };
}