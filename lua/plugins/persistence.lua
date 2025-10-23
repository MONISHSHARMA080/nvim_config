return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize", "folds" },
      -- Prevent saving directory/special buffers in future
      -- pre_save = function()
      --   pcall(vim.cmd, "Neotree close")
      -- end,
    },
    keys = {
      {
        "<leader>rs",
        function()
          require("persistence").load()

          -- Clean up unwanted buffers after restore
          vim.schedule(function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(buf) then
                local name = vim.api.nvim_buf_get_name(buf)

                -- Only check if it's a directory (most specific check)
                if name ~= "" and vim.fn.isdirectory(name) == 1 then
                  pcall(vim.api.nvim_buf_delete, buf, { force = true })
                end
              end
            end
          end)
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
