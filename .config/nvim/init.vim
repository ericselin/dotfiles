" Load plugins
lua require('plugins')

lua << EOF

vim.g.nord_italic = false
require('nord').set()

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- set up language servers
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}
lspconfig.denols.setup {
  on_attach = on_attach,
  init_options = {
    lint = true,
    unstable = true,
  },
}
lspconfig.jsonls.setup{}
-- emmet as per https://github.com/aca/emmet-ls
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.emmet_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
})

-- luasnip setup
local luasnip = require 'luasnip'
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
luasnip.filetype_extend("typescript", { "typescriptreact" })
luasnip.snippets = {
  typescript = {
    s("noti", {
      t("throw new Error(\"Not implemented\");")
    }),
    s("im", {
      t("import { "),
      i(0),
      t(" } from \""),
      i(1),
      t("\";"),
    }),
    s("imt", {
      t("import type { "),
      i(0),
      t(" } from \""),
      i(1),
      t("\";"),
    }),
    s("dete", {
      t("Deno.test(\""),
      i(1),
      t({ "\", () => {", "\t" }),
      i(0),
      t({ "", "});" });
    })
  }
}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- status line setup
require('lualine').setup {
  options = { icons_enabled = false },
  tabline = { lualine_a = { 'buffers' } },
}

EOF

colorscheme nord

" Make right hand home row navigate, just like in i3.
" n is for normal mode, v is visual and select mode
" o is for operator pending mode, i.e. `d2t`
" map without a mode specifier means n, v, o modes
" See the README for a discussion on why this has
" been configured like it has.
noremap s l
noremap t j
noremap n k
" remap Next occurence to Look
nnoremap l n
vnoremap l n
nnoremap L N
vnoremap L N
" remap unTil to untiL in operator pending mode
onoremap l t
onoremap L T
" lightspeed Seach as Jump (forward, i.e. down) and k (up)
nmap j <Plug>Lightspeed_s
nmap k <Plug>Lightspeed_S
" remap window navigation and moving
noremap <C-w>s <C-w>l
noremap <C-w>t <C-w>j
noremap <C-w>n <C-w>k
noremap <C-w>S <C-w>L
noremap <C-w>T <C-w>J
noremap <C-w>N <C-w>K
" remap window Split to spLit

" Ctrl+S save shortcut
" In normal mode, this should just write the buffer
nmap <C-s> :w<cr>
" In insert mode, go to normal and write
imap <C-s> <esc>:w<cr>

" Comma as leader key
" The leader key is useful in custom shortcuts in order to make
" good shortcuts that do not conflict with native commands.
let mapleader=','

" Search highlighting etc.
" Use `:noh` to remove highlighting
set incsearch ignorecase smartcase hlsearch

" Scroll offset, i.e. always display this many lines when scrolling
set scrolloff=10

" Line numbers hybrid mode, i.e. show current line number and the rest
" as relative to the current line. Makes e.g. navigation (`2t`) and
" deleting (`5dd`) easier.
set number relativenumber

" Tabs should be spaces - two of them; along with other smart things
" Note that autoindent is done with `=` in normal mode.
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =2
set softtabstop =2
set shiftwidth  =2
set expandtab
set autoindent
set smartindent

" EMMET config
autocmd FileType html,css :packadd emmet-vim
let g:user_emmet_leader_key=','

" fzf shortcut
noremap <C-p> :FZF<CR>

" go vim for html files
autocmd BufRead,BufNewFile */layouts/*/*.html set ft=gohtmltmpl
