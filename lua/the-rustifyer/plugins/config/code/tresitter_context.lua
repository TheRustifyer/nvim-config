return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "LazyFile",
  enabled = true,
  opts = { mode = "cursor", max_lines = 3 },
  keys = {
    {
      "<leader>ut",
      function()
        local tsc = require("treesitter-context")
        tsc.toggle()
      end,
      desc = "Toggle Treesitter Context",
    },
  },
}
