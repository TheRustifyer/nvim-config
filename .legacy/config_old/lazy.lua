-- Getting lazy.nvim as the package manager for the set up
-- Lazy only will be fetched and cloned if isn't already on the system

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')
lazy.setup('the-rustifyer.plugins', {
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { 'habamax', },
    },
    checker = { enabled = true }, -- automatically check for plugin update_in_insert
    cache = { enabled = true },
    reset_packpath = true,
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                'gzip',
                -- 'matchit',
                -- 'matchparen',
                -- 'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})
