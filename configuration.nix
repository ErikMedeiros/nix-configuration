{
  hyprland,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "erikm-desktop";

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  programs.hyprland = let
    hyprpkgs = hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    package = hyprpkgs.hyprland;
    portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;
  services.xserver.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd Hyprland \
          --remember \
          --remember-session \
          --sessions ${hyprland}/share/wayland-sessions
      '';
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    # Without this errors will spam on screen
    StandardError = "journal";
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  services.pipewire.enable = true;
  services.pipewire.wireplumber.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.erikm = {
    isNormalUser = true;
    useDefaultShell = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  environment = {
    systemPackages = with pkgs; [
      vim
      firefox
      greetd.tuigreet
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "23.11";
}
