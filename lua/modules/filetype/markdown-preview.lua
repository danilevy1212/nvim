-- Preview Markdown in your modern browser with synchronised scrolling and flexible configuration.

function OpenMarkdownPreview(url)
    os.execute('brave --new-window ' .. url)
end

---@type LazyPluginSpec
local M = {
    'iamcco/markdown-preview.nvim',
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
    build = function()
        vim.fn['mkdp#util#install']()
    end,
    config = function()
        vim.cmd [[
function OpenMarkdownPreview (url)
  execute "silent ! brave --new-window " . a:url
endfunction
]]
        vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
    end,
}

return M
