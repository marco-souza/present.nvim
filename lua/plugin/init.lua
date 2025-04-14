local M = {}

M.setup = function()
  require("plugin.cmd").register("Present", {
    show = {
      desc = "Show the presentation",
      impl = function(args)
        print("Showing presentation with args: ", vim.inspect(args))
      end,
    },
  }, { desc = "Markdown Slide Presenter" })
end

return M
