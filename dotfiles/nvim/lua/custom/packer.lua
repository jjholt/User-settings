-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use("olimorris/onedarkpro.nvim")
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

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
    branch = 'v1.x',
    requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
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
        {'simrat39/rust-tools.nvim'},

        -- Snippets
        {'L3MON4D3/LuaSnip', run = "make install_jsregexp"},             -- Required
        {'rafamadriz/friendly-snippets'}, -- Optional
    }
    }
    use("folke/zen-mode.nvim")
-- use {'SirVer/ultisnips'}
    use { 'lervag/vimtex',
    opt = true,
    config = function ()
        vim.g.vimtex_view_general_viewer = 'zathura'
        vim.g.vimtex_view_method = 'zathura'
        vim.g.tex_comment_nospell = 1
        vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex '-reuse-instance -forward-search @tex @line @pdf']]
        vim.g.vimtex_conceallevel=1
        vim.g.tex_conceal='abdmg'
        vim.g.maplocalleader = " "
    end,
    ft = 'tex'
    }
    use { 'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
        }
        -- use {'jiangmiao/auto-pairs'}
end)
