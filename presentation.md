# Hello from `present.nvim`

## What is it?

Present (`marco-souza/present.nvim`) is a simple plugin to present Markdown files as Slides

## How to

Present a Markdown Slide:

```lua
require("present.nvim").show_presentation({
  bufnr = vim.api.nvim_get_current_buf()
})
```

Navigation between slides:

- `h` - previous slide
- `l` - next slide


# World

this is the second slide
