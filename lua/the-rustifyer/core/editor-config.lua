-- This file holds the core editor's configuration and settings
--
vim.g.clipboard = "osc52"
vim.opt.clipboard = "unnamedplus"

--

vim.o.timeout = true
vim.o.timeoutlen = 10

vim.opt.guicursor = '' -- fat cursor enabled (even on insert mode)
vim.opt.termguicolors = true

-- triggers CursorHold event faster
vim.opt.updatetime = 200

-- Access colors present in 256 colorspace
vim.g.base16_colorspace = 256

-- Setting git bash on Windows by default
local is_windows = require('the-rustifyer.core.globals').sys.is_windows
if is_windows then
    local bash_options = {
        -- shell = 'C:\\msys64\\msys2_shell.cmd -defterm -here -no-start -use-full-path -mingw64 -shell zsh', --TODO: better pass later the real zsh path from MSYS2
        shellcmdflag = "-c",
        shellredir = "",
        shellpipe = "2>&1",
        shellquote = "",
        shellxquote = "",
    }

    for option, value in pairs(bash_options) do
        vim.opt[option] = value
    end

    -- Cliboard cfg.
    vim.g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf"
        },
        paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf"
        },
        cache_enabled = false
    }
end

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.tabstop = 4 -- indentation's configuration (tabs at 4, please!)
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.splitright = true -- Split to the right on vertical

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.optscrolloff = 8 -- not sure about this one, let's try it anyway
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 100

vim.opt.colorcolumn = '120' -- maybe a function per type of language in the opened current buffer?

-- Enabling folding capabilities
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99 -- No auto-folding
vim.o.foldenable = true

-- Treesitter folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- Insert two spaces after a '.', '?' and '!' with a join command.
-- Otherwise only one space is inserted.
-- Concept credit: https://github.com/tjdevries
vim.opt.joinspaces = false

vim.opt.list = true

-- List mode: By default, show tabs as ">", trailing spaces as "-", and
-- non-breakable space characters as "+". Useful to see the difference between
-- tabs and spaces and for trailing blanks. Further changed by
-- set listchars=tab:»·,trail:·,extends:↪,precedes:↩
vim.opt.listchars = {
    tab = "»·",
    trail = "·",
    extends = "↪",
    precedes = "↩",
}

-- Enabling C++ typical named modules extensions to be detected as C++ files
vim.cmd([[ autocmd BufNewFile,BufRead *.cppm set filetype=cpp ]])
vim.cmd([[ autocmd BufNewFile,BufRead *.ixx  set filetype=cpp ]])
