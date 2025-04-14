local M = {}

M.setup = function(opts)
  require("lua.cmd").register("Present", "Markdown Slide Presenter", {
    show = {
      desc = "Show the presentation",
      impl = function(args)
        -- if not markdown then skip
        local bufnr = vim.api.nvim_get_current_buf()
        local filetype = vim.bo[bufnr].filetype
        if filetype ~= "markdown" then
          vim.print("Present: Not a markdown file")
          return
        end

        require("lua.slides").start_presentation({
          bufnr = bufnr,
        })
      end,
    },
  })
end

return M
