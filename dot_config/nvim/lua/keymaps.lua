require('custom.telescope.multigrep').setup()
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-{>', '<Esc>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- set keymap for opening something
vim.keymap.set('n', '<leader>ou', vim.cmd.UndotreeToggle, { desc = 'open undotree' })
vim.keymap.set('n', '<leader>ob', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Go to lower window' })
vim.keymap.set('n', '<Leader>op', function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open file explorer' })
-- open neo git
vim.keymap.set('n', '<Leader>og', function()
  local neogit = require 'neogit'
  neogit.open()
end, { desc = 'Open neo git' })

-- open kulala menu
vim.keymap.set('n', '<Leader>ok', function()
  local utils = require 'utils'
  local kulala = require 'kulala'
  utils.show_prompt_to_selection_function('Select kulala command', {
    { 'run http request', kulala.run },
    { 'run all http request in the file', kulala.run_all },
    { 'copy as curl', kulala.copy },
    { 'paste from curl', kulala.from_curl },
    { 'select env', kulala.set_selected_env },
    { 'open', kulala.open },
    { 'scratchpad', kulala.scratchpad },
  })
end, { desc = 'Open kulala menu' })

-- set keymap for file actions
vim.keymap.set('n', '<Leader>fs', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<Leader>fS', '<cmd>wa<CR>', { desc = 'Save all files' })

-- set yank to system keyboard operation
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- this shortcut will
vim.keymap.set('x', 'p', [["_dP]])

vim.keymap.set('n', '<leader>wq', '<cmd>q<cr>', { desc = 'close buffer' })
vim.keymap.set('n', '<leader>wh', '<C-w><C-h>', { desc = 'Go to left window' })
vim.keymap.set('n', '<leader>wl', '<C-w><C-l>', { desc = 'Go to right window' })
vim.keymap.set('n', '<leader>wk', '<C-w><C-k>', { desc = 'Go to upper window' })
vim.keymap.set('n', '<leader>wj', '<C-w><C-j>', { desc = 'Go to lower window' })
vim.keymap.set('n', '<leader>wp', function()
  local current_datetime = os.date '%Y-%m-%dT%H:%M:%S'
  vim.cmd.ObsidianPasteImg(vim.fn.expand '%:p:h' .. '/attachments/' .. current_datetime)
end, { desc = 'Go to lower window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
