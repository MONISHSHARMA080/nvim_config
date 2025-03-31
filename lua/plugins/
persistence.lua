return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      -- Configure session options to save
      options = {
        "buffers",
        "curdir",
        "tabpages",
        "winsize",
        "help",
        "blank",
        "folds",
      },
    },
    -- Optional: custom keymappings for session management
    keys = {
      {
        "<leader>rs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").select()
        end,
        desc = "List Sessions",
      },
      -- Add this mapping to save/create a session
      {
        "<leader>ns",
        function()
          require("persistence").save()
        end,
        desc = "Save Session",
      },
    },
  },
}
