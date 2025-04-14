local M = {}

---@class present.Slide
---@field title string: The title of the slide
---@field body string: The body of the slide

---@class present.Slides
---@field deck present.Slide[]: The slides of the file

-- Take some lines and parses them
---@param lines string[]: The lines in the buffer
---@return present.Slides: The lines in the buffer
local parse_slides = function(lines)
  ---@type present.Slides
  local slides = { deck = {} }
  local separator = "^# "
  local current_slide = {
    title = "",
    body = {},
  }

  for _, line in ipairs(lines) do
    if line:find(separator) then
      if #current_slide.title > 0 then
        -- If we have a current slide, add it to the deck
        table.insert(slides.deck, current_slide)
      end

      current_slide = {
        title = line,
        body = {},
      }
    else
      table.insert(current_slide.body, line)
    end
  end

  -- add latest
  table.insert(slides.deck, current_slide)

  return slides
end

local function create_floating_window(opts)
  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  -- Create a new floating window
  local win = vim.api.nvim_open_win(buf, true, opts)

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
  local cur_slide = 1

  local windows = {
    header = {
      relative = "editor",
      style = "minimal",
      width = vim.o.columns,
      height = 1,
      border = "rounded",
      col = 0,
      row = 0,
    },
    body = {
      relative = "editor",
      style = "minimal",
      width = vim.o.columns,
      height = vim.o.lines - 5,
      border = { " ", " ", " ", " ", " ", " ", " ", " " },
      col = 1,
      row = 4,
    },
    -- footer = {}
  }

  local header_float = create_floating_window(windows.header)
  local body_float = create_floating_window(windows.body)

  local function set_slide_content(idx)
    local slide = parsed.deck[idx]

    local padding =
      string.rep(" ", math.floor((vim.o.columns - #slide.title) / 2))
    local title = padding .. slide.title

    vim.api.nvim_buf_set_lines(header_float.buf, 0, -1, false, { title })
    vim.api.nvim_buf_set_lines(body_float.buf, 0, -1, false, slide.body)
  end

  set_slide_content(cur_slide)

  -- navigation
  vim.keymap.set("n", "n", function()
    cur_slide = math.min(cur_slide + 1, #parsed.deck)
    set_slide_content(cur_slide)
  end, { buffer = body_float.buf })

  vim.keymap.set("n", "p", function()
    cur_slide = math.max(cur_slide - 1, 1)
    set_slide_content(cur_slide)
  end, { buffer = body_float.buf })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(body_float.win, true)
  end, { buffer = body_float.buf })

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
    buffer = body_float.buf,
    callback = function()
      for option, config in pairs(restore) do
        vim.o[option] = config.original
      end
      vim.api.nvim_win_close(header_float.win, true)
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
