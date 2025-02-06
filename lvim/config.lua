-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

------------------------------ functions ------------------------------------------
--
--
local function dadbod_config()
  local status_ok, cmp = pcall(require, "nvim-cmp")
  if status_ok then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql" },
      callback = function()
        cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
      end,
    })
  end
end
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust-analyzer" })
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "sqls"
end, lvim.lsp.automatic_configuration.skipped_servers)
------------------------------PLUGINS---------------------------------------------------------------
lvim.plugins = {
{
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
},
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufEnter",
    opts = { "*" }
  }, {

  "tris203/precognition.nvim",
  --event = "VeryLazy",
  opts = {
    startVisible = false,
    -- showBlankVirtLine = true,
    -- highlightColor = { link = "Comment" },
    -- hints = {
    --      Caret = { text = "^", prio = 2 },
    --      Dollar = { text = "$", prio = 1 },
    --      MatchingPair = { text = "%", prio = 5 },
    --      Zero = { text = "0", prio = 1 },
    --      w = { text = "w", prio = 10 },
    --      b = { text = "b", prio = 9 },
    --      e = { text = "e", prio = 8 },
    --      W = { text = "W", prio = 7 },
    --      B = { text = "B", prio = 6 },
    --      E = { text = "E", prio = 5 },
    -- },
    -- gutterHints = {
    --     G = { text = "G", prio = 10 },
    --     gg = { text = "gg", prio = 9 },
    --     PrevParagraph = { text = "{", prio = 8 },
    --     NextParagraph = { text = "}", prio = 8 },
    -- },
    -- disabled_fts = {
    --     "startify",
    -- },
  },
},
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = true,
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 10,
        max_width = 100,
        max_height = 100,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        -- get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "right",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        -- override = function(conf)
        --   return conf
        -- end,
      },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})
      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<leader>4", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
      -- Toggle previous & next buffers stored within Harpoon list
      --   vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
      --   vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end
  },
  -- {

  --   'theprimeagen/harpoon',
  --   config = function()
  --     -- Harpoon setup
  --     -- require("harpoon_mark")
  --     local harpoon_mark = require("harpoon.mark")
  --     local harpoon_ui = require("harpoon.ui")
  --     vim.keymap.set("n", "²", harpoon_mark.add_file)
  --     vim.keymap.set("n", "<C-i>", harpoon_ui.toggle_quick_menu)
  --     -- Options to do next-prev too
  --     vim.keymap.set("n", "<leader>k&", function() harpoon_ui.nav_file(1) end)
  --     vim.keymap.set("n", '<leader>ké', function() harpoon_ui.nav_file(2) end)
  --     vim.keymap.set("n", '<leader>k"', function() harpoon_ui.nav_file(3) end)
  --     vim.keymap.set("n", '<leader>k(', function() harpoon_ui.nav_file(4) end)
  --   end
  -- },
  'ThePrimeagen/vim-be-good',
  { 'glepnir/zephyr-nvim',
  },
  { "dasupradyumna/midnight.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "tpope/vim-dadbod",
    dependencies = {
      { "kristijanhusak/vim-dadbod-completion" },
      {
        "kristijanhusak/vim-dadbod-ui",
        config = dadbod_config()
      },
    },
    cmd = { "DBUI", "DBUIToggle" },
  },

}
local logo = [[
 _______           __       __
|       \         |  \     |  \
| ▓▓▓▓▓▓▓\ ______ | ▓▓   __| ▓▓____   ______   ______   ______  _______
| ▓▓  | ▓▓/      \| ▓▓  /  \ ▓▓    \ |      \ /      \ /      \|       \
| ▓▓  | ▓▓  ▓▓▓▓▓▓\ ▓▓_/  ▓▓ ▓▓▓▓▓▓▓\ \▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\
| ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓   ▓▓| ▓▓  | ▓▓/      ▓▓ ▓▓   \▓▓ ▓▓    ▓▓ ▓▓  | ▓▓
| ▓▓__/ ▓▓ ▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓\| ▓▓  | ▓▓  ▓▓▓▓▓▓▓ ▓▓     | ▓▓▓▓▓▓▓▓ ▓▓  | ▓▓
| ▓▓    ▓▓\▓▓     \ ▓▓  \▓▓\ ▓▓  | ▓▓\▓▓    ▓▓ ▓▓      \▓▓     \ ▓▓  | ▓▓
 \▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓\▓▓   \▓▓\▓▓   \▓▓ \▓▓▓▓▓▓▓\▓▓       \▓▓▓▓▓▓▓\▓▓   \▓▓
  ______________________________________________________________________
 |░▓                                   ___                             ░\
  \▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    ▓                                                                  ▓
]]
lvim.builtin.alpha.dashboard.section.header.val = vim.split(logo, "\n")

vim.cmd [[autocmd colorscheme * :hi normal guibg=none ctermbg=none]]
vim.cmd [[autocmd colorscheme * :hi NormalNC guibg=none ctermbg=none]]
-- vim.cmd [[autocmd colorscheme * :hi float guibg=none ctermbg=none]]
-- vim.cmd [[autocmd colorscheme * :hi floating guibg=none ctermbg=none]]
-- vim.cmd [[autocmd colorscheme * :hi normal ctermbg=none]]
-- vim.cmd [[autocmd colorscheme * :hi floating guibg=none]]
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- Colors :
-- //Midnight
-- wildcharm
-- tokyonight
lvim.colorscheme = "tokyonight"
lvim.builtin.lualine.options.theme = "gruvbox"

-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "sqlls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- require("lvim.lsp.manager").setup("sqlls", {
--   cmd = { "sql-language-server", "up", "--method", "stdio" },
--   filetypes = { "sql", "mysql" },
--   root_dir = function() return vim.loop.cwd() end,
-- })



-- require"colorizer".setup()

-- Parameters --

lvim.format_on_save = true
-- line display on left side
vim.o.relativenumber = true


-- Remaps --
-- nzzzv
-- Nzzzv
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-;>", ":Oil --float .<CR>")
vim.keymap.set("n", "<leader>m", function() return vim.diagnostic.open_float() end)
require 'lspconfig'.sqlls.setup {
  -- capabilities = capabilities,
  filetypes = { 'sql' },
  root_dir = function(_)
    return vim.loop.cwd()
  end,
}
-- local colors = require('midnight.colors')
-- local p = colors.palette    -- raw color palette
-- local c = colors.components -- component color powershell

-- require('midnight').setup {
--   HighlightGroup = {
--     fg = ForegroundColor, -- :h guifg
--     bg = BackgroundColor, -- :h guibg
--     sp = SpecialColor,    -- :h guisp
--     style = RenderStyle,  -- :h attr-list
--     -- OR
--     --   link = TargetHiglightGroup     -- :h :hi-link (link to "TargetHiglightGroup")
--     -- OR
--     -- clear = true                   -- :h :hi-clear (clear "HighlightGroup"; `false` ignores this option)
--   },
-- }

-- require('wildcharm.color')



if vim.g.neovide then
  local map = vim.keymap
  map.set({ "n", "v" }, "<C-è>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  map.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  map.set({ "n", "v" }, "<C-_>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end



--TODO check fonts : Agave ?
