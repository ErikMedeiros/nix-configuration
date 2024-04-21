# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{
  pkgs,
  lib,
  ...
}:
with lib.hm.gvariant; {
  home.packages = with pkgs.gnomeExtensions; [
    clipboard-indicator
    dash-to-dock
  ];

  dconf.settings = {
    "org/gnome/Console" = {
      audible-bell = false;
    };

    "org/gnome/desktop/interface" = {
      clock-show-date = true;
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 1800;
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
      num-workspaces = 1;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      confirm-clear = true;
      move-item-first = true;
      strip-text = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = true;
      autohide-in-fullscreen = false;
      background-opacity = 0.8;
      click-action = "focus-minimize-or-previews";
      custom-theme-shrink = true;
      dash-max-icon-size = 48;
      disable-overview-on-startup = true;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      icon-size-fixed = false;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      middle-click-action = "launch";
      require-pressure-to-show = true;
      shift-click-action = "minimize";
      shift-middle-click-action = "launch";
      show-trash = false;
    };
  };
}
