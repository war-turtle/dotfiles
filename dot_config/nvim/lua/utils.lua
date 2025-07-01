local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values

local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local utils = {}
-- prompt_options will be a variable of type array of array.
-- a valid value is as follows:
-- { { "quit", quit_function }, { "save", save_function }
-- where quit_function and save_function will be a function
utils.show_prompt_to_selection_function = function(prompt_title, prompt_options)
  local opts = {}
  pickers
    .new(opts, {
      prompt_title = prompt_title,
      finder = finders.new_table {
        results = prompt_options,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          selection['value'][2]()
          -- vim.api.nvim_put({ selection['value'][2] }, '', false, true)
        end)
        return true
      end,
    })
    :find()
end

return utils
