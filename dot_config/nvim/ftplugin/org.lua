-- mappings stored in this file are not cleared for some reason
-- debug it
-- for now we are using if statement inside mappings
local function get_current_headline()
  return require('orgmode.api'):current():get_closest_headline()
end

vim.keymap.set('n', '<up>', function()
  if vim.bo.filetype ~= 'org' then
    vim.api.nvim_command 'normal! k'
    return
  end
  get_current_headline():priority_up()
end, { desc = 'org increase priority' })

vim.keymap.set('n', '<down>', function()
  if vim.bo.filetype ~= 'org' then
    vim.api.nvim_command 'normal! j'
    return
  end
  get_current_headline():priority_down()()
end, { desc = 'org desc priority' })

vim.keymap.set('n', '<left>', function()
  if vim.bo.filetype ~= 'org' then
    vim.api.nvim_command 'normal! h'
    return
  end

  require('orgmode').action 'org_mappings.todo_next_state'
end, { desc = 'org next todo state' })

vim.keymap.set('n', '<right>', function()
  if vim.bo.filetype ~= 'org' then
    vim.api.nvim_command 'normal! l'
    return
  end

  require('orgmode').action 'org_mappings.todo_next_state'
end, { desc = 'org prev todo state' })
