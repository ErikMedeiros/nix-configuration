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

  maintainers = with pkgs.lib;
    packages:
      builtins.map
      (pkg: "\"${toLower (builtins.elemAt (splitString "/" pkg.meta.homepage) 3)}\"")
      packages;
in {
  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };

  home.packages = with pkgs; [
    csharp-ls
    eslint_d
    lua-language-server
    nixd
    prettierd
    stylua
    tailwindcss-language-server
    typescript-language-server
    zls
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      conform-nvim
      csharpls-extended-lsp-nvim
      fidget-nvim
      gitsigns-nvim
      indent-blankline-nvim
      lazy-nvim
      lazydev-nvim
      lualine-nvim
      luasnip
      min-theme-pkg
      nvim-cmp
      nvim-lint
      nvim-lspconfig
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
