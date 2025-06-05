{pkgs, ...}: {
  programs = {
    helix = {
      # about helix - https://helix-editor.com/
      enable = true;
      defaultEditor = true; # toggle for making it default editor
      ignores = ["!.gitignore"]; # enabling toggle
      package = pkgs.evil-helix;
      extraPackages = with pkgs; [
        nixd
        nixfmt-rfc-style
      ];

      languages = {
        language-servers = {
          nixd = {
            command = "${pkgs.nixd}/bin/nixd";
            args = [
              "--inlay-hints=true"
            ];
          };
        };

        language = [
          {
            name = "nix";
            comment-token = "#";
            injection-regex = "nix";
            auto-format = true;
            indent = {
              tab-width = 2;
              unit = "  ";
            };

            formatter = {
              command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt-rfc-style";
              args = [
                "--indent=2"
              ];
            };

            file-types = [
              "nix"
            ];

            language-servers = [
              "nixd"
            ];
          }
        ];
      };

      settings = {
        theme = "everforest_dark";
        keys = {
          normal = {
            p = ":clipboard-paste-after";
            P = ":clipboard-paste-before";
            y = ":clipboard-yank-join";
            Y = ":clipboard-yank";
          };
          select = {
            p = ":clipboard-paste-after";
            P = ":clipboard-paste-before";
            y = ":clipboard-yank-join";
            Y = ":clipboard-yank";
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
            left = [
              "mode"
              "spinner"
            ];
            center = [
              "read-only-indicator"
              "file-name"
            ];
            right = [
              "file-type"
              "position"
              "position-percentage"
              "diagnostics"
              "file-encoding"
            ];
            separator = "│";
          };
        };
      };
    };
  };
}
