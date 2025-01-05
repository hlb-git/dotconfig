vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
	use 'nvim-lualine/lualine.nvim' -- Lualine
	use 'kyazdani42/nvim-web-devicons' -- Optional, for file icons
	use 'junegunn/fzf'             -- fzf
	use 'junegunn/fzf.vim'         -- fzf.vim integration
	use 'wbthomason/packer.nvim'
	use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use 'morhetz/gruvbox'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'

end)

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
	  "javascript", "typescript", "python", "cpp", "c", "lua",
	  "vim", "vimdoc"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
}


-- Import Mason and Mason LSPConfig
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        "pyright",         -- Python
        "ts_ls",        -- JavaScript/TypeScript
        "clangd",          -- C/C++
        "lua_ls",          -- Lua
    },
    automatic_installation = true,
})

-- Import lspconfig for configuring LSP servers
local lspconfig = require('lspconfig')

-- Define an on_attach function for custom keybindings
local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Common LSP keybindings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
end

-- Configure LSP servers
lspconfig.pyright.setup { on_attach = on_attach } -- Python
lspconfig.ts_ls.setup { on_attach = on_attach } -- JavaScript/TypeScript
lspconfig.clangd.setup { on_attach = on_attach } -- C/C++
lspconfig.lua_ls.setup { -- Lua
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
}

-- Optional: Configure background style
vim.opt.background = "dark" -- Set to "light" or "dark"

vim.g.gruvbox_bold = 1      -- Enable bold
vim.g.gruvbox_contrast_dark = "hard" -- Options: 'soft', 'medium', 'hard'
vim.cmd("colorscheme gruvbox")
vim.cmd("set number relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("autocmd BufWritePre * %s/s+$//e")
vim.cmd ([[
    set splitright

    " Shortcutting split navigation, saving a keypress:
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
    syntax on
    set autoindent
    set clipboard=unnamedplus

]])


vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })     -- Find files
vim.api.nvim_set_keymap('n', '<Leader>b', ':Buffers<CR>', { noremap = true, silent = true }) -- Switch buffers
vim.api.nvim_set_keymap('n', '<Leader>l', ':Lines<CR>', { noremap = true, silent = true })   -- Search lines
vim.api.nvim_set_keymap('n', '<Leader>g', ':Rg<CR>', { noremap = true, silent = true })      -- Search with Ripgrep

require('lualine').setup {
  options = {
    icons_enabled = true,      -- Use icons in the statusline
    theme = 'material',         -- Change to match your color scheme
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},                -- Leave this empty if you don't want a tabline
  extensions = {}
}
