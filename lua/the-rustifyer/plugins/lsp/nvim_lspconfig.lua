-- nvim-lspconfig
--

local procs = require('the-rustifyer.utils.procedures')

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'williamboman/mason-lspconfig.nvim',
        },

        { -- Pops up a new buffer with the docs of the selected/highlighted text
            "amrbashir/nvim-docs-view",
            lazy = true,
            cmd = "DocsViewToggle",
            opts = {
                position = "right",
                width = 60
            }
        }
    },
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'LspStart', 'LspAttach' },
    config = function()
        -- nvim-lspconfig still provides the server definitions on the runtimepath.
        -- Neovim 0.11+ owns the actual LSP configuration/enabling API.
        require('lspconfig')

        local default_capabilities = vim.lsp.protocol.make_client_capabilities()
        default_capabilities.textDocument.completion.completionItem.snippetSupport = true
        default_capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = { 'documentation', 'detail', 'additionalTextEdits' },
        }

        vim.lsp.config('*', {
            flags = {
                debounce_text_changes = 150,
            },
            capabilities = default_capabilities,
            on_attach = function(client, bufnr)
                -- Integration with navic
                if client.server_capabilities.documentSymbolProvider then
                    require('nvim-navic').attach(client, bufnr)
                end

                -- Regular Neovim LSP client keymappings
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                procs.nnoremap('gD', vim.lsp.buf.declaration, bufopts, 'Go to declaration')
                procs.nnoremap('gd', vim.lsp.buf.definition, bufopts, 'Go to definition')
                procs.nnoremap('gi', vim.lsp.buf.implementation, bufopts, 'Go to implementation')
                procs.nnoremap('K', vim.lsp.buf.hover, bufopts, 'Hover text')
                procs.nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, 'Show signature')
                procs.nnoremap('<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts, 'Add workspace folder')
                procs.nnoremap('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts, 'Remove workspace folder')
                procs.nnoremap('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts, 'List workspace folders')
                procs.nnoremap('<leader>D', vim.lsp.buf.type_definition, bufopts, 'Go to type definition')
                procs.nnoremap('<leader>rn', vim.lsp.buf.rename, bufopts, 'Rename')
                procs.nnoremap('<leader>ca', vim.lsp.buf.code_action, bufopts, 'Code actions')
                vim.keymap.set('v', '<leader>ca', function()
                    vim.lsp.buf.code_action()
                end, { noremap = true, silent = true, buffer = bufnr, desc = 'Code actions' })
                procs.nnoremap('<leader>=', function()
                    vim.lsp.buf.format { async = true }
                    vim.cmd('%s/\\s\\+$//e')
                end, bufopts, 'Format file')
            end,
        })

        vim.lsp.config('clangd', {
            on_attach = require('the-rustifyer.utils.clangd_on_attach'),
        })

        vim.lsp.config('lua_ls', require('lsp-zero').nvim_lua_ls())

        require('mason-lspconfig').setup({
            handlers = {
                function(server_name)
                    if server_name == 'rust_analyzer' or server_name == 'jdtls' then
                        return
                    end

                    vim.lsp.enable(server_name)
                end,
            },
        })

        -- rust_analyzer is handled by rustaceanvim.
        -- jdtls is configured through ftplugin.

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN] = '▲',
                    [vim.diagnostic.severity.HINT] = '⚑',
                    [vim.diagnostic.severity.INFO] = '»',
                },
            },
        })
    end,
}
