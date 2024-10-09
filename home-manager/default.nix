{pkgs, ...}: {
  imports = [./hyprland.nix ./neovim];

  # nix.gc.automatic = true;

  home = {
    username = "erikm";
    homeDirectory = "/home/erikm";

    packages = with pkgs; [
      dbeaver-bin
      nautilus
      parallel
      slack
      webcord
    ];

    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;
    foot.enable = true;

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

    thefuck = {
      enable = true;
      enableZshIntegration = true;
    };

    vscode.enable = true;

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
