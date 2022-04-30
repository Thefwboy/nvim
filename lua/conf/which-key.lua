local M = {}
function M.setup()
  require("which-key").setup
    {
        plugins = {
            spelling = {
                -- 是否接管默认 z= 的行为
                enabled = true,
                suggestions = 20
            }
        }
    }
end
return M

