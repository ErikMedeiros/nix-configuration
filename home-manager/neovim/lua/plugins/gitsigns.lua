return {
  "lewis6991/gitsigns.nvim",
  opts = {
    numhl = true,
    current_line_blame = true,
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
      end

      map("]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "Next Hunk")

      map("[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "Previous Hunk")

      map("<leader>hp", gitsigns.preview_hunk, "[P]review Hunk")
      map("<leader>hs", gitsigns.stage_hunk, "[S]tage Hunk")
      map("<leader>hu", gitsigns.undo_stage_hunk, "[U]ndo Stage Hunk")
      map("<leader>hr", gitsigns.reset_hunk, "[R]eset Hunk")

      map("<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "[S]tage Hunk", "v")
      map("<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "[R]eset Hunk", "v")

      map("<leader>hS", gitsigns.stage_buffer, "[S]tage Buffer")
      map("<leader>hR", gitsigns.reset_buffer, "[R]eset Buffer")

      map("<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, "[B]lame Line")

      map("<leader>hd", gitsigns.diffthis, "[D]iff Against Index")
      map("<leader>hD", function()
        gitsigns.diffthis("~")
      end, "[D]iff Against Last Commit")

      map("ih", ":<C-U>Gitsigns select_hunk<CR>", "inner hunk", { "o", "x" })
    end,
  },
}
