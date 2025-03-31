-- lua/plugins/copilot.lua
return {
  {
    "zbirenbaum/copilot.lua",
    enabled = function()
      -- Check if we can connect to Copilot
      local ok, _ = pcall(require("copilot.client").is_available)
      return ok
    end,
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          dismiss = "<C-]>",
        },
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    enabled = function()
      -- Only enable if the main copilot plugin can connect
      local ok, _ = pcall(require("copilot.client").is_available)
      return ok
    end,
  },
}
