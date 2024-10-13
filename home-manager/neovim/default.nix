{
  config,
  pkgs,
  min-theme,
  ...
}: let
  min-theme-pkg = pkgs.vimUtils.buildVimPlugin {
    pname = "min-theme-nvim";
    version = "2024-01-07";
    src = min-theme;
    meta.homepage = "https://github.com/datsfilipe/min-theme.nvim";
  };

  maintainers = packages:
    builtins.map
    (pkg: "\"${builtins.elemAt (pkgs.lib.splitString "/" pkg.meta.homepage) 3}\"")
    packages;
in {
  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };

  home.packages = with pkgs; [
    stylua
    eslint_d
    prettierd
  ];

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      conform-nvim
      indent-blankline-nvim
      lazy-nvim
      lualine-nvim
      min-theme-pkg
      nvim-lint
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      plenary-nvim
      telescope-nvim
      vim-sleuth
      which-key-nvim
    ];

    extraLuaConfig = let
      path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start";

      patterns =
        builtins.concatStringsSep
        ",\n      "
        (pkgs.lib.unique (maintainers config.programs.neovim.plugins));
    in ''
      require("config")

      require("lazy").setup({
        spec = { { import = "plugins" } },
        performance = {
          reset_packpath = false,
          rtp = { reset = false }
        },
        dev = {
          path = "${path}",
          patterns = {
            ${patterns}
          },
        },
        install = { missing = false },
      })
    '';
  };
}
