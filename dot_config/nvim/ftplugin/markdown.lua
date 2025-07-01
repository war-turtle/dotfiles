-- Define a function to move to the next line and insert a character
local function insert_char_next_line(char)
  -- Move the cursor down to the next line
  vim.cmd 'normal! o'

  -- Insert the character at the new position
  vim.api.nvim_put({ char }, 'c', true, true)
end

vim.keymap.set('n', '<leader>il', function()
  insert_char_next_line '- [ ]'
end, { desc = 'insert markdown list' })
