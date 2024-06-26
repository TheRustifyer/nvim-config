-- Configuration for the debugger adapter
--

return {
    {
        'mfussenegger/nvim-dap',
        dependencies = { {'nvim-neotest/nvim-nio'} },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            require('nvim-dap-virtual-text').setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    },
    {
        'Weissle/persistent-breakpoints.nvim',
        event = 'BufReadPost',
        config = function()
            require('persistent-breakpoints').setup {
                load_breakpoints_event = { "BufReadPost" }
            }
        end,
    },
}
