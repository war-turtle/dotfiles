-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `opts` key (recommended), the configuration runs
-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

return {
  { -- Useful plugin to show you pending keybinds.
    'ahmedkhalf/project.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('project_nvim').setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        detection_methods = { 'pattern' },
        patterns = { '.git', 'package.json', 'go.mod', '>hswork', '>work', '.obsidian' },
      }
      require('telescope').load_extension 'projects'

      vim.keymap.set('n', '<leader>or', function()
        require('telescope').extensions.projects.projects {}
      end, { desc = 'open projects' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
