-- Preview Markdown in your modern browser with synchronised scrolling and flexible configuration.
--- TODO  Try out https://github.com/yousefhadder/markdown-plus.nvim

---@type LazyPluginSpec
local M = {
    'sammaji/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    keys = {
        {
            '<LocalLeader>p',
            '<Cmd>MarkdownPreviewToggle<Cr>',
            desc = 'Markdown Preview Toggle',
            ft = 'markdown',
        },
        {
            '<LocalLeader>o',
            '<Cmd>MarkdownPreview<Cr>',
            desc = 'Markdown Preview Start',
            ft = 'markdown',
        },
        {
            '<LocalLeader>c',
            '<Cmd>MarkdownPreviewStop<Cr>',
            desc = 'Markdown Preview Stop',
            ft = 'markdown',
        },
    },
    ft = { 'markdown' },
    config = function()
        local browser = (function()
            if require('dan.lib.os').is_macos() then
                return [[open -a Google\ Chrome -n --args]]
            else
                return 'brave'
            end
        end)()

        vim.cmd(string.format(
            [[
function OpenMarkdownPreview (url)
  execute 'silent ! %s --new-window ' . a:url
endfunction
]],
            browser
        ))
        vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
    end,
}

return M
