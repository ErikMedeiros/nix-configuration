{
  pkgs,
  extensions,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    extensions =
      (with pkgs.vscode-extensions; [
        ms-dotnettools.csdevkit
        ms-dotnettools.csharp
      ])
      ++ (with extensions.vscode-marketplace; [
        adpyke.codesnap
        bradlc.vscode-tailwindcss
        dbaeumer.vscode-eslint
        eamodio.gitlens
        esbenp.prettier-vscode
        miguelsolorio.min-theme
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
      "codesnap.realLineNumbers" = true;
      "codesnap.showWindowControls" = false;
      "codesnap.showWindowTitle" = true;
      "codesnap.shutterAction" = "copy";
      "codesnap.target" = "window";
      "csharp.experimental.debug.hotReload" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.minimap.size" = "fit";
      "workbench.colorTheme" = "Min Dark";
      "workbench.iconTheme" = "material-icon-theme";
      "zig.initialSetupDone" = true;
      "zig.path" = "zig";
      "zig.zls.path" = "zls";
    };
  };
}
