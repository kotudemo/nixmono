{pkgs, ...}: {
  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
        clear
        fastfetch
        eval "$(starship init bash)"
        [[ $- == *i* ]] && source "$(blesh-share)"/ble.sh --noattach
        [[ ! ''${BLE_VERSION-} ]] || ble-attach
      '';
    };
    /*
      blesh = {
        enable = true;
        options = {
        prompt_ps1_transient = "trim:same-dir";
        prompt_ruler = "empty-line";
        };
        blercExtra = ''
        function my/complete-load-hook {
            bleopt complete_auto_history=1
            bleopt complete_ambiguous=1
            bleopt complete_menu_maxlines=-10
            bleopt complete_auto_delay=1
        };
        blehook/eval-after-load complete my/complete-load-hook
        '';
    };
    */
  };
}
