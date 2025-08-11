-- From a fresh install, run :so within this file

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use("olimorris/onedarkpro.nvim")
    use("mrcjkb/rustaceanvim")
    use("tpope/vim-surround")
    use('nvim-treesitter/nvim-treesitter',
        {dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'}},
        {run = ':TSUpdate'}
    )
    use{'theprimeagen/harpoon', branch = "harpoon2", requires = { "nvim-lua/plenary.nvim"}}
    use('mbbill/undotree')
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
    -- use('github/copilot.vim')
    use('tpope/vim-fugitive')
    use('nvim-treesitter/nvim-treesitter-context')
    use('nvim-lua/plenary.nvim')
    use('mfussenegger/nvim-dap')

    use{'L3MON4D3/LuaSnip',
        requires = {
            'hrsh7th/nvim-cmp',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        }
    }

    use('neovim/nvim-lspconfig')
    use('mason-org/mason.nvim')
    use('mason-org/mason-lspconfig.nvim')
    use({ "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
          }
      end
    })
    use 'lervag/vimtex'
    use {'numToStr/Comment.nvim', config = function() require('Comment').setup() end}
    --
    -- Status bar stuff
    use{'feline-nvim/feline.nvim', requires = {'lewis6991/gitsigns.nvim'}}
    use('nvim-tree/nvim-web-devicons')
end)
