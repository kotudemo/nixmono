{ config, lib, pkgs, ... }:

{
  programs.wofi = {
    enable = true;

    settings = {
      hide_scroll = true;
      show = "drun";
      width = "30%";
      lines = 8;
      line_wrap = "word";
      term = "ghostty";
      allow_markup = true;
      always_parse_args = false;
      show_all = true;
      print_command = true;
      layer = "overlay";
      allow_images = true;
      sort_order = "alphabetical";
      gtk_dark = true;
      prompt = "";
      image_size = 20;
      display_generic = false;
      location = "center";
      key_expand = "Tab";
      insensitive = false;
    };

    style = ''
      * {
        font-family: JetBrainsMonoNerd;
        color: #ebdbb2;
        background: transparent;
      }

      #window {
        background: #1d2021;
        margin: auto;
        padding: 10px;
        border-radius: 20px;
        border: 5px solid #e8cb94;
      }

      #input {
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 15px;
      }

      #outer-box {
        padding: 20px;
      }

      #img {
        margin-right: 6px;
      }

      #entry {
        padding: 10px;
        border-radius: 15px;
      }

      #entry:selected {
        background-color: #282828;
      }

      #text {
        margin: 2px;
      }
    '';
  };
}
