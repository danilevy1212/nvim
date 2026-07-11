--- DAP utils
local M = {}

--- Create a coroutine that prompts the user for debug arguments via vim.ui.input.
--- @return thread -- The created coroutine, resumed with a table of space-separated args (or empty table).
function M.get_args_coroutine()
    return coroutine.create(function(co)
        vim.ui.input({ prompt = 'Args (space-separated, empty for none): ' }, function(a)
            if a == '' or not a then
                coroutine.resume(co, {})
            else
                coroutine.resume(co, vim.split(a, '%s+'))
            end
        end)
    end)
end

return M
