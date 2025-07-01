return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup {
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
        mappings = {
          prefix = '<leader>j',
          org_return_uses_meta_return = true,
          note = {
            org_priority = '<leader>jp',
            org_priority_down = 'c<down>',
          },
        },
        org_todo_keywords = { 'TODO(t)', 'INPROGRESS(i)', '|', 'DONE(d)' },
        org_adapt_indentation = false,
        org_startup_indented = true,
      }

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
}
