{...}: {
  programs = {
    helix = {
      # about helix - https://helix-editor.com/
      defaultEditor = true; # toggle for making it default editor
      enable = true;
      ignores = ["!.gitignore"]; # enabling toggle
      settings = {
        theme = "tokyonight";
        editor = {
          line-number = "relative";
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
          };
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          statusline = {
            mode.normal = "NORMALCOCK";
            mode.insert = "ZHIDKOSRAL";
            mode.select = "DVASTYLA";
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
