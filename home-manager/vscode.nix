{
  nix-vscode-extensions,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    enableUpdateCheck = false;

    extensions = let
      exts = nix-vscode-extensions.extensions.${pkgs.system};
    in (with exts.vscode-marketplace; [
      adpyke.codesnap
      bradlc.vscode-tailwindcss
      dbaeumer.vscode-eslint
      eamodio.gitlens
      esbenp.prettier-vscode
      miguelsolorio.min-theme
      ms-dotnettools.csdevkit
      ms-dotnettools.csharp
      ms-dotnettools.vscode-dotnet-runtime
      pkief.material-icon-theme
      styled-components.vscode-styled-components
      usernamehw.errorlens
      vadimcn.vscode-lldb
      ziglang.vscode-zig
    ]);

    userSettings = {
      "[csharp]" = {
        "editor.defaultFormatter" = "ms-dotnettools.csharp";
      };
      "[typescript][typescriptreact][javascript][javascriptreact][json][jsonc][html][markdown]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      "codesnap.realLineNumbers" = true;
      "codesnap.showWindowControls" = false;
      "codesnap.showWindowTitle" = true;
      "codesnap.shutterAction" = "copy";
      "codesnap.target" = "window";

      "csharp.experimental.debug.hotReload" = true;

      "editor.fontFamily" = "'FiraCode Nerd Font Mono', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.inlayHints.enabled" = "off";
      "editor.linkedEditing" = true;
      "editor.minimap.size" = "fit";
      "editor.smoothScrolling" = true;

      "explorer.compactFolders" = false;

      "extensions.ignoreRecommendations" = true;

      "terminal.integrated.smoothScrolling" = true;
      "terminal.integrated.stickyScroll.enabled" = true;

      "window.confirmSaveUntitledWorkspace" = false;

      "workbench.colorTheme" = "Min Dark";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.list.smoothScrolling" = true;
      "workbench.tips.enabled" = false;

      "zig.initialSetupDone" = true;
      "zig.path" = "zig";
      "zig.zls.path" = "zls";
    };
  };
}
