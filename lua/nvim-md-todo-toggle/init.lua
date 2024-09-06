local M = {}

M.config = {
  marker = { " ", "x" },
}

M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})

  vim.api.nvim_create_user_command("TDToggle", M.toggle, { bang = true, desc = "Toggle between todo states" })
  vim.api.nvim_create_user_command("TDAdd", M.add, { bang = true, desc = "Add a new todo item to the next line" })
end

M.toggle = function()
  local line = vim.api.nvim_get_current_line()

  local count = 0
  local currentStateIdx = -1
  local currentMarker = ""
  for i, state in ipairs(M.config.marker) do
    local isInState, _ = string.find(line, "- %[" .. state .. "%]")
    count = count + 1
    if isInState then
      currentStateIdx = i
      currentMarker = state
    end
  end
  local nextStateIdx = currentStateIdx == count and 1 or currentStateIdx + 1
  local nextMarker = M.config.marker[nextStateIdx]

  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  vim.cmd(":.,.s/\\[" .. currentMarker .. "\\]/[" .. nextMarker .. "]/")
  vim.cmd(":noh")
  vim.cmd(":call cursor(" .. cursor_pos[1] .. ", " .. cursor_pos[2] + 1 .. ")")
end

M.add = function()
  vim.cmd(":norm o- [ ] ")
  vim.cmd(":startinsert!")
end

return M
