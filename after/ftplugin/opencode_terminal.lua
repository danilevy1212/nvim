require('opencode.server').get_port(function(ok, port)
    if not ok then
        vim.notify('Could not establish connection to opencode', vim.log.levels.WARN, {
            title = 'opencode',
        })
    end

    require('opencode.client').listen_to_sse(port, function(response)
        vim.api.nvim_exec_autocmds('User', {
            pattern = 'OpencodeEvent',
            data = response,
        })
    end)
end)
