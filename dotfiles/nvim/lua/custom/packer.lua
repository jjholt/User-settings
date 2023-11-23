-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use("olimorris/onedarkpro.nvim")
    use('nvim-treesitter/nvim-treesitter',
        {dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'}},
        {run = ':TSUpdate'}
    )
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('nvim-treesitter/nvim-treesitter-context')
    use('nvim-lua/plenary.nvim')
    use('mfussenegger/nvim-dap')

    use('folke/zen-mode.nvim', {
        opts = {
            window = {width = 180},
        }
    })
    use({ "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
          }
      end
    })
    use{'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},         -- Required
        {'hrsh7th/cmp-nvim-lsp'},     -- Required
        {'hrsh7th/cmp-buffer'},       -- Optional
        {'hrsh7th/cmp-path'},         -- Optional
        {'saadparwaiz1/cmp_luasnip'}, -- Optional
        {'hrsh7th/cmp-nvim-lua'},     -- Optional
        {'hrsh7th/cmp-nvim-lsp-signature-help'},
        {'hrsh7th/cmp-vsnip'},
        {'hrsh7th/vim-vsnip'},

        -- Snippets
        {'L3MON4D3/LuaSnip', run = "make install_jsregexp"},             -- Required
        {'rafamadriz/friendly-snippets'}, -- Optional
    }
    }
-- use {'SirVer/ultisnips'}
    use('simrat39/rust-tools.nvim')
    use 'lervag/vimtex'
    -- use 'KeitaNakamura/tex-conceal.vim'
    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
    -- Status bar stuff
    use('feline-nvim/feline.nvim')
    use('nvim-tree/nvim-web-devicons')
end)
