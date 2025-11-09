-- Better buffer closing function
local M = {}

-- Smart buffer close - closes buffer but keeps window
function M.close_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufcount = #vim.fn.getbufinfo({ buflisted = 1 })
  
  -- If this is the last buffer, open a new empty buffer first
  if bufcount <= 1 then
    vim.cmd("enew")
  else
    vim.cmd("bprevious")
  end
  
  -- Delete the original buffer
  vim.api.nvim_buf_delete(bufnr, { force = false })
end

-- Force close buffer
function M.force_close_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufcount = #vim.fn.getbufinfo({ buflisted = 1 })
  
  if bufcount <= 1 then
    vim.cmd("enew")
  else
    vim.cmd("bprevious")
  end
  
  vim.api.nvim_buf_delete(bufnr, { force = true })
end

-- Close all buffers except current
function M.close_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  
  for _, buf in ipairs(buffers) do
    if buf ~= current and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
  
  vim.notify("Closed all other buffers", vim.log.levels.INFO)
end

return M
