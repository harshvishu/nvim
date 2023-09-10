--- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use("nvim-treesitter/playground")
    use("theprimeagen/harpoon")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("nvim-treesitter/nvim-treesitter-context");

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
            --{'simrat39/inlay-hints.nvim'},
            --{'lvimuser/lsp-inlayhints.nvim'},
        }
    }

    use("folke/zen-mode.nvim")
    use("laytan/cloak.nvim")
    use {
        'gelguy/wilder.nvim',
        config = function()
            -- config goes here
        end,
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use('rust-lang/rust.vim')
    use('ellisonleao/gruvbox.nvim')

    use { 'simrat39/rust-tools.nvim' }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use { "theHamsta/nvim-dap-virtual-text" }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use "lukas-reineke/indent-blankline.nvim"
    use "lewis6991/gitsigns.nvim"
end)

