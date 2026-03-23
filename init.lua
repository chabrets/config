-- Basics
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.shortmess:append("I")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  
  -- File explorer
  { 
    "nvim-tree/nvim-tree.lua", 
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
    end
  },

  -- LSP & Mason
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },
  
  -- Autocompletion
  { 
    "hrsh7th/nvim-cmp", 
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip" },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'path' } })
      })
    end
  },

  -- Treesitter
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
      local status, ts = pcall(require, "nvim-treesitter.configs")
      if status then
        ts.setup({
          ensure_installed = { "python", "go", "c", "cpp", "lua", "bash", "yaml" },
          highlight = { enable = true },
          indent = { enable = true },
        })
      end
    end
  },
})

-- UI & Theme
vim.cmd.colorscheme "catppuccin"

-- LSP Setup
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { "pyright", "gopls", "clangd" }

require("mason-lspconfig").setup({ ensure_installed = servers })

for _, lsp in ipairs(servers) do
  if vim.lsp.config then
    vim.lsp.config(lsp, { options = { capabilities = capabilities } })
  else
    require('lspconfig')[lsp].setup({ capabilities = capabilities })
  end
end

-- LSP Keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)

-- Auto-open nvim-tree
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    if data.file == "" then require("nvim-tree.api").tree.open() end
  end
})
