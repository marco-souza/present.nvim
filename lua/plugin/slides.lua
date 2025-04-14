local M = {}

---@class present.Slides
---@field deck string[]: The slides of the file

-- Take some lines and parses them
---@param lines string[]: The lines in the buffer
---@return present.Slides: The lines in the buffer
local parse_slides = function(lines)
  ---@type present.Slides
  local slides = { deck = {} }
  local current_slide = {}
  local separator = "^#"

  for _, line in ipairs(lines) do
    if line:find(separator) then
      if #current_slide > 0 then
        -- If we have a current slide, add it to the deck
        table.insert(slides.deck, current_slide)
      end

      current_slide = {}
    end

    table.insert(current_slide, line)
  end

  -- add latest
  table.insert(slides.deck, current_slide)

  return slides
end

function create_floating_window(opts)
  -- Set default options if not provided
  opts = opts or {}

  local width = opts.width or vim.o.columns
  local height = opts.height or vim.o.lines

  local row = opts.row or math.floor((vim.o.lines - height) / 2)
  local col = opts.col or math.floor((vim.o.columns - width) / 2)

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  -- Create a new floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = { " ", " ", " ", " ", " ", " ", " ", " " },
  })

  -- enable markdown styling
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

  -- Return the buffer and window handles
  return { buf = buf, win = win }
end

M.start_presentation = function(opts)
  opts = opts or {}
  opts.bufnr = opts.bufnr or 0

  local lines = vim.api.nvim_buf_get_lines(opts.bufnr, 0, -1, false)
  local parsed = parse_slides(lines)
  local float = create_floating_window()

  local cur_slide = 1

  vim.api.nvim_buf_set_lines(float.buf, 0, -1, false, parsed.deck[cur_slide])

  -- navigation
  vim.keymap.set("n", "n", function()
    cur_slide = math.min(cur_slide + 1, #parsed.deck)
    vim.api.nvim_buf_set_lines(float.buf, 0, -1, false, parsed.deck[cur_slide])
  end, { buffer = float.buf })

  vim.keymap.set("n", "p", function()
    cur_slide = math.max(cur_slide - 1, 1)
    vim.api.nvim_buf_set_lines(float.buf, 0, -1, false, parsed.deck[cur_slide])
  end, { buffer = float.buf })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(float.win, true)
  end, { buffer = float.buf })

  local restore = {
    cmdheight = {
      original = vim.o.cmdheight,
      present = 0,
    },
  }

  -- set the options we want during presentation
  for option, config in pairs(restore) do
    vim.o[option] = config.present
  end

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = float.buf,
    callback = function(_ev)
      for option, config in pairs(restore) do
        vim.o[option] = config.original
      end
    end,
  })
end

-- vim.print(parse_slides({
--   "# Slide 1",
--   "This is the first slide",
--   "",
--   "# Slide 2",
--   "This is the second slide",
-- }))

M.start_presentation({
  bufnr = 5,
})

return M
