-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
local cmp = require("cmp")

local function setup_tab_mappings()
  return {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }
end

if cmp then
  cmp.setup({
    mapping = setup_tab_mappings(),
  })
end

-- Move the current window left or right
-- vim.keymap.set("n", "<S-Left>", "<C-w>H", { desc = "Move window to the far left" })
-- vim.keymap.set("n", "<S-Right>", "<C-w>L", { desc = "Move window to the far right" })
vim.keymap.set("n", "<S-Left>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
vim.keymap.set("n", "<S-Right>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })

-- Buffer navigation with Tab and Shift-Tab
-- vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer", silent = true })
-- vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer", silent = true })

-- vim.keymap.set("n", "<C-w>", ":bd<CR>", { desc = "Close current buffer", silent = true })
--vim.keymap.set("n", "<C-w>", ":bp|bd #<CR>", { desc = "Close current buffer and move to previous", silent = true })
vim.keymap.set("n", "<C-w>", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf)
      and vim.api.nvim_buf_get_option(buf, "buflisted")
      and buf ~= current_buf
      and vim.bo[buf].filetype ~= "NvimTree" -- Exclude NvimTree buffers
      and vim.bo[buf].filetype ~= "neo-tree" -- Exclude neo-tree buffers
      and vim.bo[buf].filetype ~= "CHADTree" -- Exclude CHADTree buffers
  end, vim.api.nvim_list_bufs())

  if #buffers > 0 then
    vim.api.nvim_set_current_buf(buffers[1])
    vim.cmd("bd " .. current_buf)
  else
    vim.cmd("bd")
  end
end, { desc = "Close current buffer and move to another file", silent = true })

------
vim.keymap.set("x", "p", "pgvy", { desc = "Paste without losing buffer" })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without losing buffer" })
