local M = {}

M.setup = function(opts)
  require("lua.cmd").register("Present", "Markdown Slide Presenter", {
    show = {
      desc = "Show the presentation",
      impl = function(args)
        require("lua.slides").start_presentation({
          bufnr = vim.api.nvim_get_current_buf(),
        })
      end,
    },
  })
end

return M
