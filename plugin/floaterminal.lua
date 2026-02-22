local M = {}

local state = {
  buf = nil,
  win = nil,
}

local function create_terminal_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buflisted', false)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'hide')
  return buf
end

local function calculate_centered_dimensions(width, height)
  local ui = vim.api.nvim_list_uis()[1]
  local col = math.floor((ui.width - width) / 2)
  local row = math.floor((ui.height - height) / 2)
  return {
    width = width,
    height = height,
    col = col,
    row = row,
  }
end

function M.toggle()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
    return
  end

  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = create_terminal_buffer()
    vim.api.nvim_buf_call(state.buf, function()
      vim.fn.termopen(vim.o.shell)
      vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { buffer = state.buf, noremap = true })
    end)
  end

  local dims = calculate_centered_dimensions(80, 24)

  local opts = {
    relative = 'editor',
    width = dims.width,
    height = dims.height,
    row = dims.row,
    col = dims.col,
    border = 'rounded',
  }

  state.win = vim.api.nvim_open_win(state.buf, true, opts)
  vim.api.nvim_win_set_option(state.win, 'winblend', 0)

  vim.cmd('startinsert')
end

function M.open()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_set_current_win(state.win)
    return
  end
  M.toggle()
end

function M.close()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
  end
end

vim.api.nvim_create_user_command('FloaterminalToggle', function()
  M.toggle()
end, {})

vim.api.nvim_create_user_command('FloaterminalOpen', function()
  M.open()
end, {})

vim.api.nvim_create_user_command('FloaterminalClose', function()
  M.close()
end, {})

vim.keymap.set('n', '<Leader>tt', M.toggle, { noremap = true, silent = true })

return M
