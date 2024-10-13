{pkgs, ...}: {
  imports = [./hyprland.nix ./neovim ./vscode.nix];

  # nix.gc.automatic = true;

  fonts.fontconfig.enable = true;

  home = let
    dotnet-sdk = with pkgs.dotnetCorePackages; combinePackages [sdk_6_0 sdk_8_0];
  in {
    username = "erikm";
    homeDirectory = "/home/erikm";

    sessionPath = ["$HOME/.dotnet/tools"];
    sessionVariables = {
      DOTNET_ROOT = "${dotnet-sdk}";
    };

    packages = with pkgs; [
      dbeaver-bin
      dotnet-sdk
      fira-code-nerdfont
      nautilus
      nodejs_20
      parallel
      slack
      webcord
      zig
    ];

    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;

      oh-my-zsh = {
        enable = true;
        theme = "half-life";
        plugins = ["git" "dotnet" "npm" "tldr"];
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    jq.enable = true;
    ripgrep.enable = true;
    fd.enable = true;

    thefuck = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = "Erik Medeiros";
      userEmail = "erikmedeiros4@gmail.com";
      extraConfig.init.defaultBranch = "main";

      includes = [
        {
          condition = "gitdir:~/repos/gbm";
          contents.user.email = "erik.medeiros@gbmlogistica.com.br";
        }
      ];
    };
  };
}
