-- ~/.config/nvim/lua/plugins/pyrefly.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyrefly = {
          cmd = { "pyrefly", "lsp" },
          filetypes = { "python" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.find_git_ancestor(fname)
              or lspconfig.util.find_node_modules_ancestor(fname)
              or lspconfig.util.path.dirname(fname)
          end,
          settings = {
            python = {
              pythonPath = "/home/monish/miniconda3/envs/cs229/bin/python",
              analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
              },
            },
          },
          on_exit = function(code, _, _)
            vim.notify("Pyrefly LSP exited with code: " .. code, vim.log.levels.INFO)
          end,
          single_file_support = true,
        },
      },
      setup = {
        pyrefly = function(_, opts)
          local lspconfig = require("lspconfig")
          local configs = require("lspconfig.configs")

          -- Register pyrefly if not already registered
          if not configs.pyrefly then
            configs.pyrefly = {
              default_config = {
                cmd = opts.cmd,
                filetypes = opts.filetypes,
                root_dir = opts.root_dir,
                settings = opts.settings,
                on_exit = opts.on_exit,
                single_file_support = opts.single_file_support,
              },
            }
          end

          -- Setup the server
          lspconfig.pyrefly.setup(opts)
          return true -- Important: return true to prevent default setup
        end,
      },
    },
  },

  -- Optional: Add mason support for automatic installation
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- Note: pyrefly might not be available in mason, so you may need to install it manually
      -- via pip: pip install pyrefly
    end,
  },

  -- Optional: Configure which-key descriptions
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>cp", group = "pyrefly", icon = "🔥" },
      },
    },
  },
}
