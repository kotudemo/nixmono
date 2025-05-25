{
  lib,
  pkgs,
  vscode-utils,
  ...
}: {
  programs = {
    vscode = {
      enable = true;
      profiles = {
        default = {
          extensions = with pkgs.vscode-extensions; [
            yzhang.markdown-all-in-one
            jnoortheen.nix-ide
            redhat.vscode-yaml
            enkia.tokyo-night
          ];

          userSettings = lib.mkForce {
            #"editor.fontFamily" = "'Hack Nerd Font'";
            #"editor.fontSize" = 16;

            "editor.cursorBlinking" = "smooth";
            "editor.cursorSmoothCaretAnimation" = "on";
            #"editor.wordWrap" = "on";

            #"workbench.colorTheme" = "Blazing Red";
            #"workbench.sideBar.location" = "right";
            #"workbench.activityBar.location" = "top";
            #"workbench.editor.editorActionsLocation" = "titleBar";
            #"workbench.editor.showTabs" = "none";

            #"window.menuBarVisibility" = "hidden";

            "files.autoSave" = "afterDelay";

            "[nix]" = {
              "editor.insertSpaces" = true;
              "editor.tabSize" = 4;
            };
          };
        };
      };
    };
  };
}
