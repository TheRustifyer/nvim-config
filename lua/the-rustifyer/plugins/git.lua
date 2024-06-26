return {
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufRead', 'BufNewFile' },
        opts = {
            signs = {
                add = { text = '▎' },
                change = { text = '▎' },
                delete = { text = '' },
                topdelete = { text = '' },
                changedelete = { text = '▎' },
                untracked = { text = '▎' },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map('n', 'nh', gs.next_hunk, 'Next Hunk')
                map('n', 'ph', gs.prev_hunk, 'Prev Hunk')
                map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
                map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
                map('n', '<leader>gsb', gs.stage_buffer, 'Stage Buffer')
                map('n', '<leader>gus', gs.undo_stage_hunk, 'Undo Stage Hunk')
                map('n', '<leader>grb', gs.reset_buffer, 'Reset Buffer')
                map('n', '<leader>ghp', gs.preview_hunk_inline, 'Preview Hunk Inline')
                map('n', '<leader>gbl', function() gs.blame_line({ full = true }) end, 'Blame Line')
                map('n', '<leader>ghd', gs.diffthis, 'Diff This')
                map('n', '<leader>ghD', function() gs.diffthis('~') end, 'Diff This ~')
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
            end,
        },
    },
    {
        'ThePrimeagen/git-worktree.nvim',
    },
    {
        'topaxi/gh-actions.nvim',
        cmd = 'GhActions',
        -- optional, you can also install and use `yq` instead.
        build = 'cargo',
        dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' },
        opts = {},
        config = function(_, opts)
            require('gh-actions').setup(opts)
        end,
    },
    {
        'tpope/vim-fugitive',
        event = 'VeryLazy',
        cmd = { "Git", "Gwrite", "Gdiffsplit", "Gvdiffsplit" }
    },
    {
        'akinsho/git-conflict.nvim',
        event = 'VeryLazy',
        version = '1.3.0',
        dependencies = {
            'yorickpeterse/nvim-pqf',
            config = function()
                require('pqf').setup({
                    signs = {
                        error = 'E',
                        warning = 'W',
                        info = 'I',
                        hint = 'H'
                    },
                    show_multiple_lines = false,
                    max_filename_length = 0,
                })
            end
        },
        config = function()
            require 'git-conflict'.setup {
                default_mappings = {
                    ours = 'o',
                    theirs = 't',
                    none = '0',
                    both = 'b',
                    next = 'n',
                    prev = 'p',
                },
            }
        end
    }
}
