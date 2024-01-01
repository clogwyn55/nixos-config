local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end


vim.opt.rtp:prepend(lazypath)
-- set options
-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'                 -- allow the mouse to be used in Nvim

-- Tab
vim.opt.tabstop = 4                 -- number of visual spaces per TAB
vim.opt.softtabstop = 4             -- number of spacesin tab when editing
vim.opt.shiftwidth = 4              -- insert 4 spaces on a tab
vim.opt.expandtab = true            -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true               -- show absolute number
vim.opt.relativenumber = true       -- add numbers to each line on the left side
vim.opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true           -- open new vertical split bottom
vim.opt.splitright = true           -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false            -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true            -- search as characters are entered
vim.opt.hlsearch = false            -- do not highlight matches
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered

-- Set Plugins
require('lazy').setup({
  {'Mofiqul/dracula.nvim'},
  {'elkowar/yuck.vim'},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    }
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'L3MON4D3/LuaSnip'}
    },
  },
})

vim.opt.termguicolors = true
vim.cmd.colorscheme('dracula')

-- necessary for NixOS
local lsp_zero_config = {
    call_servers = 'global',
}

local lsp_servers = {
    'lua_ls',
}

local lua_ls_config = {
    settings = {
        Lua = {
            diagnostics = {globals = {'vim'}},
            runtime = {version = 'LuaJIT'},
            telemetry = {enable = false},
        },
    },
}

-- Keymaps
local opts = {
    noremap = true;
    silent = true,
}

local function on_attach(_, bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})
end

vim.keymap.set('i', '<C-h>', '<Left>', opts)
vim.keymap.set('i', '<C-j>', '<Down>', opts)
vim.keymap.set('i', '<C-k>', '<Up>', opts)
vim.keymap.set('i', '<C-l>', '<Right>', opts)

-- Put LSP plugins here
require('lspconfig').docker_compose_language_service.setup({})
require('lspconfig').nil_ls.setup({})
require('lspconfig').pylyzer.setup({})
require('lspconfig').taplo.setup({})
require('lspconfig').lemminx.setup({})

local diagnostics_config = {
	-- Omitted for brevit
}

return {
    'VonHeikemen/lsp-zero.nvim',
    config = function()
        local lsp = require('lsp-zero')
        lsp.set_preferences(lsp_zero_config)

        lsp.configure('lua_ls', lua_ls_config)

        lsp.setup_servers(lsp_servers)
        lsp.on_attach(on_attach)
        lsp.setup()

        vim.diagnostic.config(diagnostics_config)
    end,
    dependencies = {
        {'neovim/nvim-lspconfig'},
    },
}
