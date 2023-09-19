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
lvim.plugins = {
  'ThePrimeagen/vim-be-good',
  { 'glepnir/zephyr-nvim',
  },
  { "dasupradyumna/midnight.nvim" }

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

vim.cmd [[autocmd colorscheme * :hi normal guibg=none]]


lvim.colorscheme = "midnight"



lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "sqlls"
end, lvim.lsp.automatic_configuration.skipped_servers)

require("lvim.lsp.manager").setup("sqlls", {
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "mysql" },
  root_dir = function() return vim.loop.cwd() end,
})




-- Parameters --

lvim.format_on_save = true
-- line display on left side
vim.o.relativenumber = true


-- Remaps --
-- nzzzv
-- Nzzzv
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
