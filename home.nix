{ config, pkgs, ... }:

{
  home.username = "erikm";
  home.homeDirectory = "/home/erikm";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    zig
    zls
    nodejs_18
    (with dotnetCorePackages; combinePackages [ sdk_6_0 sdk_8_0 ])
  ];

  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "dotnet" "ripgrep" ];	
      };
    };

    git = {
      enable = true;
      userName = "Erik Medeiros";
      userEmail = "erikmedeiros4@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        includeIf."gitdir/i:~/repos/gbm/".email = "dev23.gbmlogistica@outlook.com.br";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    ripgrep.enable = true;
  };
}
