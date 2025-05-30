{pkgs, ...}: {
  programs = {
    helix = {
      # about helix - https://helix-editor.com/
      defaultEditor = true; # toggle for making it default editor
      package = pkgs.evil-helix;
      enable = true;
      ignores = ["!.gitignore"]; # enabling toggle
      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "alejandra";
        }
      ];
      settings = {
        theme = "everforest_dark";
        keys = {
          normal = {
            p = ":clipboard-paste-after";
            P = ":clipboard-paste-before";
            y = ":clipboard-yank-join";
            Y = ":clipboard-yank";
            R = ":clipboard-paste-replace";
            d = [":clipboard-yank-join" "delete_selection"];
          };
          select = {
            p = ":clipboard-paste-after";
            P = ":clipboard-paste-before";
            y = ":clipboard-yank-join";
            Y = ":clipboard-yank";
            R = ":clipboard-paste-replace";
            d = [":clipboard-yank-join" "delete_selection"];
          };
          insert = {
            "A-x" = "normal_mode";
            C-p = "move_line_up";
            C-n = "move_line_down";
            C-e = "goto_line_end_newline";
            C-a = "goto_line_start";
            C-f = "move_char_right";
            C-b = "move_char_left";
          };
        };
        editor = {
          line-number = "relative";
          evil = false;
          mouse = false;
          smart-tab.enable = true;
          file-picker = {
            hidden = true;
            follow-symlinks = true;
            deduplicate-links = true;
            parents = true;
            ignore = true;
            git-ignore = true;
            git-global = true;
            git-exclude = true;
          };
          lsp = {
            enable = true;
            display-messages = true;
          };
          indent-guides = {
            render = true;
            rainbow-option = "dim";
          };
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          statusline = {
            mode.normal = "NORMAL";
            mode.insert = "INSERT";
            mode.select = "VISUAL";
            left = ["mode" "spinner"];
            center = ["read-only-indicator" "file-name"];
            right = ["file-type" "position" "position-percentage" "diagnostics" "file-encoding"];
            separator = "│";
          };
        };
      };
    };
  };
}
