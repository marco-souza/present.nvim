local M = {}

M.setup = function(opts)
  vim.print("Setting up plugin with options: ", vim.inspect(opts))

  require("present.cmd").register("Present", "Markdown Slide Presenter", {
    show = {
      desc = "Show the presentation",
      impl = function(args)
        require("present.slides").start_presentation({
          bufnr = vim.api.nvim_get_current_buf(),
        })
      end,
    },
  })
end

return M
