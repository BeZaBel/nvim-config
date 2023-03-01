--[[

  ███    ██ ██    ██ ██ ███    ███ 
  ████   ██ ██    ██ ██ ████  ████ 
  ██ ██  ██ ██    ██ ██ ██ ████ ██ 
  ██  ██ ██  ██  ██  ██ ██  ██  ██ 
  ██   ████   ████   ██ ██      ██ .lua

]]--

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- catppuccin
    'rebelot/kanagawa.nvim', name = "kanagawa",
  },

  { -- duskfox
    'EdenEast/nightfox.nvim', name = "duskfox",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("duskfox")
    end,
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  {'akinsho/toggleterm.nvim', version = "*", config = true },

  { 'antonk52/markdowny.nvim',
  config = function()
      require('markdowny').setup{filetypes = {'markdown', 'txt'}}
    end
  },

  { 'brenoprata10/nvim-highlight-colors',
  config = function()
      require('nvim-highlight-colors').setup()
    end
  },

  { 'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  },

  {
  'mawkler/modicator.nvim',
    dependencies = 'EdenEast/nightfox.nvim', -- Add your colorscheme plugin here
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    config = function()
      require('modicator').setup()
    end,
  },

  {'m4xshen/autoclose.nvim',
    config = function()
      require('autoclose').setup()
    end,
  },

  { 'echasnovski/mini.nvim', version = false,
  config = function ()
    require('mini.map').setup()
  end,
  },

  -- No config needed
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',
  'lervag/vimtex',
  'SirVer/ultisnips',
  'karb94/neoscroll.nvim',
--  'xiyaowong/nvim-transparent',
  'akinsho/bufferline.nvim',
  'jalvesaq/Nvim-R',
  'KeitaNakamura/tex-conceal.vim',
  'frabjous/knap',
  'folke/tokyonight.nvim',

}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
vim.o.t_ZH = '^[[3m'

vim.o.t_ZR = '^[[23m'

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.o.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable cursorline
vim.o.cursorline = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Vimtex configs

vim.g.vimtex_view_general_viewer = 'llpp'
vim.g.vimtex_compiler_method = 'tectonic'
vim.o.conceallevel = 1
vim.g.tex_conceal = 'adbmg'

-- ultisnips stuff

vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-m>"

-- R stuff

vim.g.R_app = 'radian'
vim.g.R_cmd = 'R'
vim.g.R_hl_term = 0
vim.g.R_bracketed_paste = 1

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Custom Keymaps
vim.keymap.set({ 'n', 'v' }, '<C-l>', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader><C-p>', ':BufferLineTogglePin<CR>')
vim.keymap.set({ 'n', 'v' }, '<C-A-l>', ':BufferLineMoveNext<CR>')
vim.keymap.set({ 'n', 'v' }, '<C-A-h>', ':BufferLineMovePrev<CR>')
vim.keymap.set({ 'n', 'v' }, '<C-A-j>', ':BufferLineCycleNext<CR>')
vim.keymap.set({ 'n', 'v' }, '<C-A-k>', ':BufferLineCyclePrev<CR>')
vim.keymap.set({ 'n', 'v' }, '<C-A-w>', ':bd<CR>')

-- Toggleterm keymaps

vim.keymap.set({ 'n', 'v' }, '<leader>ev', ':ToggleTerm size=80 direction=vertical<CR>', { desc = 'Open vertical terminal' })
vim.keymap.set({ 'n', 'v' }, '<leader>es', ':ToggleTerm size=15 direction=horizontal<CR>', { desc = 'Open horizontal terminal' })
vim.keymap.set({ 'n', 'v' }, '<leader>ef', ':ToggleTerm direction=float<CR>', { desc = 'Open floating terminal'})
vim.keymap.set({ 'n', 'v' }, '<leader>et', ':ToggleTerm direction=float<CR>', { desc = 'Toggle terminal'})

-- KNAP keymaps
vim.keymap.set({ 'n', 'v' }, '<leader><F5>', function() require("knap").process_once() end)
vim.keymap.set({ 'n', 'v' }, '<leader><F6>', function() require("knap").close_viewer() end)
vim.keymap.set({ 'n', 'v' }, '<leader><F7>', function() require("knap").toggle_autopreviewing() end)
vim.keymap.set({ 'n', 'v' }, '<leader><F8>', function() require("knap").forward_jump() end)

-- Splits

vim.keymap.set( { 'n', 'v' }, '<leader>wv', ':vsplit<CR>', { desc = 'Open vertical split' } )
vim.keymap.set( { 'n', 'v' }, '<leader>wc', ':split<CR>', { desc = 'Open horizontal split' } )

-- Mini map

vim.keymap.set( { 'n', 'v' }, '<leader>mc', MiniMap.close, { desc = 'Close mini.map' } )
vim.keymap.set( { 'n', 'v' }, '<leader>mf', MiniMap.toggle_focus, { desc = 'Focus mini.map' } )
vim.keymap.set( { 'n', 'v' }, '<leader>mo', MiniMap.open, { desc = 'Open mini.map' } )
vim.keymap.set( { 'n', 'v' }, '<leader>mr', MiniMap.refresh, { desc = 'Refresh mini.map' } )
vim.keymap.set( { 'n', 'v' }, '<leader>ms', MiniMap.toggle_side, { desc = 'Toggle side of mini.map' } )
vim.keymap.set( { 'n', 'v' }, '<leader>mm', MiniMap.toggle, { desc = 'Toggle mini.map' } )

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- nvim-tree setup

require("nvim-tree").setup{
  sort_by = "case_sensitive",
  view = {
    adaptive_size = false,
    preserve_window_proportions = true,
    width = 26,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
    float = {
        enable = false,
        open_win_config = {
        width = 26,
        height = 40,
        col = 3,
        row = 1,
        },
      },
  },
  renderer = {
    group_empty = true,
  },
  git = {
    enable = true,
  },
  filters = {
    dotfiles = true,
  },
}

local open_side_tree = vim.api.nvim_create_augroup('openNvimTree', { clear = true })
vim.api.nvim_create_autocmd( 'VimEnter', {
  callback = function()
    require('nvim-tree.api').tree.open()
  end,
  group = open_side_tree,
})

local function tab_win_closed(winnr)
  local api = require"nvim-tree.api"
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else                                                      -- else closed buffer was normal buffer
    if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
        vim.schedule(function ()
          if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
            vim.cmd "quit"                                        -- then close all of vim
          else                                                  -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
          end
        end)
      end
    end
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function ()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true
})

-- Bufferline config

require('bufferline').setup{
    options = {
        -- or 'tabs'
        mode = 'buffers',
        -- 'none', 'ordinal', 'buffer_id', 'both'
        numbers = 'none',
        -- See :h bufferline.nvim section on 'Mouse actions'
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,
        indicator = {
            icon = '▎',
            -- 'icon', 'underline', 'none'
            style = 'icon'
        },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 20,
        max_prefix_lenght = 15,
        truncate_names = true,
        tab_size = 20,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_buffer_default_icon = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        -- 'slant', 'thick', 'thin'
        separator_style = 'slope',
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        },
        -- insert_after_current, insert_at_end, 'id',
        -- 'extension', 'relative_directory', 'tabs'
        sort_by = 'tabs'
    }
}

-- nvim transparent

-- require("transparent").setup({
--   enable = true, -- boolean: enable transparent
--   extra_groups = { -- table/string: additional groups that should be cleared
--     -- In particular, when you set it to 'all', that means all available groups
--
--     -- example of akinsho/nvim-bufferline.lua
--     "BufferLineTabClose",
--     "BufferlineBufferSelected",
--     "BufferLineFill",
--     "BufferLineBackground",
--     "BufferLineSeparator",
--     "BufferLineIndicatorSelected",
--   },
--   exclude = {}, -- table: groups you don't want to clear
-- })

-- toggleterm setup

require('toggleterm').setup{
  size = 10,
  open_mapping = [[<F7>]],
  shading_factor = 2,
  direction = 'float',
  float_opts = {
    border = 'curved',
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
}

-- neoscroll stuff
require('neoscroll').setup{}

-- KNAP stuff

local gknapsettings = {
  texoutputext = "pdf",
  textopdf = "tectonic --synctex --outfmt pdf %docroot%",
  textopdfviewerlaunch = "sioyek %outputfile%",
  textopdfviewerrefresh = "none",
  textopdfforwardjump = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,%3)\"' --reuse-window --forward-search-file %srcfile% --forward-search-line %line% %outputfile%",
  mdoutputext = "html",
  mdtohtml = "pandoc -s -f gfm -t html5 -o %outputfile% %docroot%",
  mdtohtmlviewerlaunch = "live-server --quiet --browser=firefox --open=%outputfile% --watch=%outputfile% --wait=100",
  mdtohtlmviewerrefresh = "none",
  delay = 200
}
vim.g.knap_settings = gknapsettings

local close_server = vim.api.nvim_create_augroup('closeLiveServer', { clear = true })
vim.api.nvim_create_autocmd('BufUnload', {
  callback = function()
    if (vim.b.knap_viewerpid)
    then os.execute("pkill -f live-server")
    end
  end,
  group = close_server,
  pattern = "*.md"
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
