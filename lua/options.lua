local opt = vim.opt
local g = vim.g

-- Turn these off at startup, will be enabled later just before loading the theme
vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])

opt.ruler = false
opt.hidden = true
opt.ignorecase = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.cursorline = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 500 -- update interval for gitsigns
--opt.timeout = false
opt.timeoutlen = 400
opt.clipboard = "unnamedplus"
opt.scrolloff = 10

-- disable nvim intro
opt.shortmess:append("sI")

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
vim.cmd("let &fcs='eob: '")

-- Numbers
opt.number = true
opt.numberwidth = 2
-- opt.relativenumber = true

-- Indenline
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = -1
opt.autoindent = true
opt.smartindent = true

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
--opt.whichwrap:append("<>hl")

g.mapleader = " "
g.auto_save = false

-- Keep undo history across sessions by storing it in a file
if vim.fn.has('persistent_undo') == 1 then
    local paths = {
        "/tmp/nvim/undo",
        (os.getenv("PREFIX") or "") .. "/tmp/nvim/undo",
    }

    for key,value in ipairs(paths)
    do
        os.execute("mkdir -p -m700 " .. value)
        local ok, err, code = os.rename(value, value)
        if ok then
            opt.undodir = value
            opt.undofile = true

            break
        end
    end
end
opt.undolevels = 1000
opt.undoreload = 10000

-- use ripgreg instead of grep
opt.grepprg="rg --vimgrep"

-- crontab filetype tweak (the way vim normally saves files confuses crontab
-- so this workaround allows for editing
vim.cmd("autocmd FileType crontab setlocal bkc=yes")

-- disable builtin vim plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

local M = {}

-- file extension specific tabbing
-- vim.cmd([[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])

return M
