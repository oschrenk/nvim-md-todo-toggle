local function setup(parameters)
  print("printing from setup()")
end

print("I have been started")

local function toggle_todo_marker()
  local line = vim.api.nvim_get_current_line()
  local opened, _ = string.find(line, "- %[ %]")
  local closed, _ = string.find(line, "- %[x%]")
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  if opened then
    vim.cmd(':.,.s/\\[ \\]/[x]/')
  elseif closed then
    vim.cmd(':.,.s/\\[x\\]/[ ]/')
  end
  vim.cmd(":noh")
  vim.cmd(":call cursor(" .. cursor_pos[1] .. ", " .. cursor_pos[2]+1 .. ")")
end

vim.keymap.set("n", "<leader>t", toggle_todo_marker, { desc = "jurst ran it", noremap = true, silent = true })

vim.api.nvim_create_user_command(
  'TDToggle',
  toggle_todo_marker,
  { bang = true, desc = 'bang, what is bang?' }
)

return {
  setup = setup,
}
