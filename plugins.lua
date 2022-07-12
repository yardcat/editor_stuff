
------------------------ fzf lua ---------------------------
local actions = require "fzf-lua.actions"
require('fzf-lua').setup{
  files = {
    prompt            = 'Files❯ ',
    multiprocess      = false,           -- run command in a separate process
    git_icons         = false,           -- show git icons?
    file_icons        = false,           -- show file icons?
    color_icons       = false,           -- colorize file|git icons
    cmd               = "cat fzf.cache",
    actions = {
      ["default"]     = actions.file_tabedit,
      ["ctrl-y"]      = function(selected) print(selected[1]) end,
    }
  },
  oldfiles = {
    actions = {
      ["default"]     = actions.file_tabedit,
    }
  },
  git = {
    status = {
      prompt        = 'GitStatus❯ ',
      cmd           = "git status -s",
      file_icons    = false,
      git_icons     = false,
      color_icons   = false,
      previewer     = "git_diff",
      actions = {
        ["right"]   = { actions.git_unstage, actions.resume },
        ["left"]    = { actions.git_stage, actions.resume },
      },
    },
  },
  grep = {
    prompt            = 'Rg❯ ',
    input_prompt      = 'Grep For❯ ',
    multiprocess      = true,           -- run command in a separate process
    git_icons         = false,           -- show git icons?
    file_icons        = false,           -- show file icons?
    color_icons       = false,           -- colorize file|git icons
    -- cmd               = "grep",
    cwd               = vim.fn.expand('%'),
    grep_opts         = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
  },
  winopts = {
    height=0.4,
    width=1.0,
    row=0.9,
    col=0.0,
  },
  preview = {
    border         = 'border',        -- border|noborder, applies only to
    wrap           = 'nowrap',        -- wrap|nowrap
    hidden         = 'nohidden',      -- hidden|nohidden
    vertical       = 'down:45%',      -- up|down:size
    horizontal     = 'right:60%',     -- right|left:size
    layout         = 'flex',          -- horizontal|vertical|flex
    flip_columns   = 120,             -- #cols to switch to horizontal on flex
    title          = true,            -- preview border title (file/buf)?
    scrollbar      = 'float',         -- `false` or string:'float|border'
    scrolloff      = '-2',            -- float scrollbar offset from right
    scrollchars    = {'█', '' },      -- scrollbar chars ({ <full>, <empty> }
    delay          = 100,             -- delay(ms) displaying the preview
    winopts = {                       -- builtin previewer window options
      number            = true,
      relativenumber    = false,
      cursorline        = true,
      cursorlineopt     = 'both',
      cursorcolumn      = false,
      signcolumn        = 'no',
      list              = false,
      foldenable        = false,
      foldmethod        = 'manual',
    },
  },
  actions = {
    files = {
      ["default"]     = actions.file_edit_or_qf,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["alt-q"]       = actions.file_sel_to_qf,
    },
    buffers = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
    }
  },
}

------------------------ telescope ---------------------------
-- require('telescope').setup{
--   defaults = {
--     layout_config = {
--       vertical = { width = 0.5 }
--     },
--     mappings = {
--       i = {
--         ["<C-h>"] = "which_key"
--       }
--     }
--   },
--   pickers = {
--   },
--   extensions = {
--   }
-- }
--
-- vim.keymap.set('n', 'gf', require('telescope.builtin').find_files, opts)
-- vim.keymap.set('n', 'gh', require('telescope.builtin').oldfiles, opts)
-- vim.keymap.set('n', 'gb', require('telescope.builtin').buffers, opts)
-- vim.keymap.set('n', 'gr', require('telescope.builtin').registers, opts)
-- vim.keymap.set('n', 'gm', require('telescope.builtin').resume, opts)

------------------------ marks ---------------------------
require'marks'.setup {
  mappings = {
    set_next = "m,",
    preview = "m;",
  },
  default_mappings = true,
  builtin_marks = { ".", "<", ">", "^" },
  cyclic = true,
  force_write_shada = false,
  refresh_interval = 250,
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  excluded_filetypes = {},
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world"
  },
  mappings = {}
}

------------------------ monokai ---------------------------
require('monokai').setup {
  palette = {
    base2 = '#211F22',
    base6 = '#72696A',
  },
}

------------------------ indent ---------------------------
vim.opt.list = true
--vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

------------------------ rainbow ---------------------------
require("nvim-treesitter.configs").setup {
  highlight = {
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

------------------------ auto pair ---------------------------
require("nvim-autopairs").setup {}

------------------------ comment ---------------------------
require('Comment').setup({
  padding = true,
  sticky = true,
  ignore = nil,
  toggler = {
    line = ',cc',
    block = ',bb',
  },
  opleader = {
    line = ',c',
    block = ',b',
  },
  extra = {
    above = 'gcO',
    below = 'gco',
    eol = 'gcA',
  },
  mappings = {
    basic = true,
    extra = true,
    extended = false,
  },
})

------------------------ nvim-cmp ---------------------------
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}
require('lspconfig')['jdtls'].setup {
  capabilities = capabilities
}

-- lsp.clangd.setup({
--   handlers = lsp_status.extensions.clangd.setup(),
--   init_options = {
--     clangdFileStatus = true
--   },
--   on_attach = mix_attach,
--   capabilities = lsp_status.capabilities
-- })


------------------------------ treesitter --------------------------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp" , "java" },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
}
