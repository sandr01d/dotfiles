local g = vim.g
-- use space as leader key
g.mapleader = ' '
g.maplocalleader = ' '

-- behaves like :set
local opt = vim.opt
-- show line numbers
opt.number = true
-- highlight text lines the cursor is in
opt.cursorline = true
-- automatically read outside changes
opt.autoread = true
opt.tabstop = 4

-- used for individual plugins further below
local keymap = vim.keymap
-- colorscheme
require'gruvbox'.setup {
    transparent_mode = true
}
vim.cmd('colorscheme gruvbox')

-- treesitter plugin
require'nvim-treesitter.configs'.setup {
    highlight = {
	enable = true,
    },
    incremental_selection = {
	enable = true,
	keymaps = {
	    -- ctrl + n to select more
	    init_selection = "<C-n>",
	    node_incremental = "<C-n>",
	    scope_incremental = "<C-s>",
	    -- ctrl + b to select less
	    node_decremental = "<C-b>",
	},
    }
}
-- tree-sitter based folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

-- autoclose plugin
require'autoclose'.setup()

-- telescope fuzzy finder
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        ["<M-k>"] = "preview_scrolling_up",
        ["<M-j>"] = "preview_scrolling_down",
      }
    }
  }
}
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>ff',  builtin.find_files, {})
-- list previously opened files
keymap.set('n', '<leader>fo', builtin.oldfiles, {})
keymap.set('n', '<leader>fg', builtin.live_grep, {})
keymap.set('n', '<leader>fb', builtin.buffers, {})
keymap.set('n', '<leader>fh', builtin.help_tags, {})
keymap.set('n', '<leader>fk', builtin.keymaps, {})

-- misc. keymap
-- disable highlight and finish search
keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- language server
local lspconf = require'lspconfig'

-- nil for nix
lspconf.nil_ls.setup {
  -- autostart = true,
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixfmt" },
      },
    }
  }
}

-- lua-language-server for lua
lspconf.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      })
      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

-- completions
local luasnip = require'luasnip'
local cmp = require'cmp'

local has_words_before = function ()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-Tab>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.abort(),
    -- accept currently selected item
    ['<CR>'] = cmp.mapping.confirm { select = true },
    -- cycle through completions
    ['<Tab>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    -- cycle through completions reverse
    ['<S-Tab>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s"}),
  }
}

