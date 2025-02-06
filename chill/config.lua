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

lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "sqls"
end, lvim.lsp.automatic_configuration.skipped_servers)
------------------------------PLUGINS---------------------------------------------------------------
lvim.plugins = {
  {
    'norcalli/nvim-colorizer.lua',
    --   lazy = false,
    --   config = function()
    -- end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  'ThePrimeagen/vim-be-good',
  { 'glepnir/zephyr-nvim',
  },
  { "dasupradyumna/midnight.nvim" },
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

-- if (!vim.g.NEOVIDE) then
-- vim.cmd [[autocmd colorscheme * :hi normal guibg=none]]
-- end



lvim.colorscheme = "lunar"



-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "sqlls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- require("lvim.lsp.manager").setup("sqlls", {
--   cmd = { "sql-language-server", "up", "--method", "stdio" },
--   filetypes = { "sql", "mysql" },
--   root_dir = function() return vim.loop.cwd() end,
-- })



-- require("colorizer").setup()

-- Parameters --

lvim.format_on_save = true
-- line display on left side
vim.o.relativenumber = true


-- Remaps --
-- nzzzv
-- Nzzzv
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


-- Harpoon setup
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "²", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
-- Options to do next-prev too
vim.keymap.set("n", "<leader>²&", function() harpoon:list().select(1) end)
vim.keymap.set("n", '<leader>²é', function() harpoon:list().select(2) end)
vim.keymap.set("n", '<leader>²"', function() harpoon:list().select(3) end)
vim.keymap.set("n", '<leader>²(', function() harpoon:list().select(4) end)


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
