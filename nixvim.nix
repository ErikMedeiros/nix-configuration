{...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      undofile = true;
      title = true;
      breakindent = true;
      termguicolors = true;
      background = "dark";
      hlsearch = false;
    };

    colorschemes.kanagawa = {
      enable = true;
      settings = {
        background.dark = "dragon";
      };
    };

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    autoGroups = {
      YankHighlight.clear = true;
    };

    autoCmd = [
      {
        event = "TextYankPost";
        pattern = "*";
        group = "YankHighlight";
        callback.__raw = ''
          function()
            vim.highlight.on_yank({ timeout = 200 })
          end
        '';
      }
    ];

    keymaps =
      map (key: {
        mode = "n";
        key = key;
        action = "v:count == 0 ? 'g${key}' : '${key}'";
        options = {
          expr = true;
          silent = true;
        };
      }) ["k" "j"]
      ++ map (key: {
        mode = "n";
        key = key;
        action = "${key}zz";
      }) ["n" "N" "<C-d>" "<C-u>"]
      ++ [
        {
          mode = ["n" "v"];
          action = "<Nop>";
          key = "<Space>";
          options.silent = true;
        }
        {
          mode = "n";
          action = "<cmd>cprev<CR>";
          key = "[q";
        }
        {
          mode = "n";
          action = "<cmd>cnext<CR>";
          key = "]q";
        }
        {
          mode = "n";
          action = "<cmd>lprev<CR>";
          key = "[l";
        }
        {
          mode = "n";
          action = "<cmd>lnext<CR>";
          key = "]l";
        }
        {
          mode = "n";
          action = "<cmd>Format<CR>";
          key = "<leader>f";
        }
      ];

    plugins = {
      cmp = let
        mapSource = map (source: {name = source;});
      in {
        enable = true;
        settings = {
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          mapping = {
            "<C-e>" = "cmp.mapping.close()";
            "<C-Space>" = "cmp.mapping.complete()";

            "<CR>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require'luasnip'
                if cmp.visible() then
                  if luasnip.expandable() then
                      luasnip.expand()
                  else
                      cmp.confirm({ select = true, })
                  end
                else
                    fallback()
                end
              end)
            '';

            "<C-p>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require'luasnip'
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';

            "<C-n>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require'luasnip'
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.locally_jumpable(1) then
                  luasnip.jump(1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          };
          sources = mapSource ["nvim_lsp" "luasnip" "path" "buffer"];
        };

        cmdline = {
          "/" = {
            mapping.__raw = "cmp.mapping.preset.cmdline()";
            sources = mapSource ["buffer"];
          };
          "?" = {
            mapping.__raw = "cmp.mapping.preset.cmdline()";
            sources = mapSource ["buffer"];
          };
          ":" = {
            mapping.__raw = "cmp.mapping.preset.cmdline()";
            sources = mapSource ["path" "cmdline"];
          };
        };
      };

      comment.enable = true;

      fidget.enable = true;
      fugitive.enable = true;

      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          on_attach = ''
            function(bufnr)
              local gitsigns = require("gitsigns")
              vim.keymap.set("n", "<leader>gp", gitsigns.prev_hunk, { buffer = bufnr, desc = "[G]o to [P]revious Hunk" })
              vim.keymap.set("n", "<leader>gn", gitsigns.next_hunk, { buffer = bufnr, desc = "[G]o to [N]ext Hunk" })
              vim.keymap.set("n", "<leader>ph", gitsigns.preview_hunk, { buffer = bufnr, desc = "[P]review [H]unk" })
            end
          '';
        };
      };

      indent-blankline.enable = true;

      lsp = {
        enable = true;

        keymaps = {
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>e" = "open_float";
          };
          lspBuf = {
            K = "hover";
            "<C-k>" = "signature_help";
            "<leader>rn" = "rename";
          };
          extra = let
            telescope = "require('telescope.builtin')";
          in [
            {
              mode = "n";
              action = "${telescope}.lsp_definitions";
              key = "gd";
              lua = true;
              options.desc = "LSP: [G]oto [D]efinitions";
            }
            {
              mode = "n";
              action = "${telescope}.lsp_type_definitions";
              key = "gt";
              lua = true;
              options.desc = "LSP: [G]oto [T]ype Definitions";
            }
            {
              mode = "n";
              action = "${telescope}.lsp_references";
              key = "gr";
              lua = true;
              options.desc = "LSP: [G]oto [R]eferences";
            }
            {
              mode = "n";
              action = "${telescope}.lsp_implementations";
              key = "gi";
              lua = true;
              options.desc = "LSP: [G]oto [I]mplementations";
            }
            {
              mode = "n";
              action = "${telescope}.lsp_document_symbols";
              key = "<leader>ds";
              lua = true;
              options.desc = "LSP: [D]ocument [S]ymbols";
            }
            {
              mode = "n";
              action = "${telescope}.lsp_workspace_symbols";
              key = "<leader>ws";
              lua = true;
              options.desc = "LSP: [W]orkspace [S]ymbols";
            }
          ];
        };

        servers = {
          cssls.enable = true;
          emmet_ls.enable = true;
          eslint.enable = true;
          gopls.enable = true;
          html.enable = true;
          htmx.enable = true;
          jsonls.enable = true;
          nil_ls.enable = true;

          omnisharp = {
            enable = true;
            settings = {
              enableImportCompletion = true;
              enableRoslynAnalyzers = true;
              organizeImportsOnFormat = true;
            };
          };

          tsserver.enable = true;
          zls.enable = true;
        };
      };

      lsp-format.enable = true;

      lualine = {
        enable = true;
        iconsEnabled = false;
      };

      luasnip.enable = true;

      none-ls = {
        enable = true;
        enableLspFormat = true;
        sources = {
          completion.luasnip.enable = true;
          hover.dictionary.enable = true;

          code_actions = {
            refactoring.enable = true;
            gitsigns.enable = true;
          };

          formatting = {
            alejandra.enable = true;
            csharpier.enable = true;
            gofmt.enable = true;
            prettier = {
              enable = true;
              disableTsServerFormatter = true;
            };
          };
        };
      };

      sleuth.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader><space>" = {
            action = "buffers";
            options.desc = "[ ] Find Existing Buffers";
          };
          "<leader>/" = {
            action = "current_buffer_fuzzy_find";
            options.desc = "[/] Fuzzily search in current buffer";
          };
          "<leader>?" = {
            action = "oldfiles";
            options.desc = "[?] Find recently opened files";
          };
          "<leader>sf" = {
            action = "find_files";
            options.desc = "[S]earch [F]iles";
          };
          "<leader>gf" = {
            action = "git_files";
            options.desc = "Search [G]it [F]iles";
          };
          "<leader>sk" = {
            action = "keymaps";
            options.desc = "[S]earch [K]eymaps";
          };
          "<leader>sh" = {
            action = "help_tags";
            options.desc = "[S]earch [H]elp";
          };
          "<leader>sw" = {
            action = "grep_string";
            options.desc = "[S]earch Current [W]ord";
          };
          "<leader>sg" = {
            action = "live_grep";
            options.desc = "[S]earch By [G]rep";
          };
          "<leader>sd" = {
            action = "diagnostics";
            options.desc = "[S]earch [D]iagnostics";
          };
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
          insert_mappings = false;
          terminal_mappings = false;
          open_mapping = "[[<leader>t]]";
        };
      };

      treesitter = {
        enable = true;
        indent = true;
      };

      which-key.enable = true;
    };
  };
}
