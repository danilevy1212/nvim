local group = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP_PREFIX .. 'misc', {
    clear = false,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    desc =
    'Set cursor to last place it was on before exiting. Taken from `https://this-week-in-neovim.org/2023/Jan/2#tips`',
    group = group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd('BufReadPre', {
    desc =
    'Add source and code information to the vim.diagnostics virtual text and quickfix list. Format: message :: source :: code',
    group = group,
    callback = function()
        --- @param diagnostic Diagnostic
        --- @return string
        local function format_diagnostic(diagnostic)
            local extra_info = vim.tbl_filter(function(value)
                return value ~= nil
            end, { diagnostic.message, diagnostic.source, diagnostic.code })

            return table.concat(extra_info, ' :: ')
        end

        --- Diagnostics configuration
        vim.diagnostic.config {
            float = {
                border = 'rounded',
                source = true,
                severity_sort = true,
            },
            virtual_text = {
                format = format_diagnostic,
            },
        }

        --- Override `vim.diagnostic.toqflist` to display `source` and `code` information
        --- @see vim.diagnostic.toqflist
        --- @diagnostic disable-next-line:duplicate-set-field
        vim.diagnostic.toqflist = function(diagnostics)
            local errlist_type_map = {
                [vim.diagnostic.severity.ERROR] = 'E',
                [vim.diagnostic.severity.WARN] = 'W',
                [vim.diagnostic.severity.INFO] = 'I',
                [vim.diagnostic.severity.HINT] = 'N',
            }

            vim.validate {
                diagnostics = {
                    diagnostics,
                    vim.tbl_islist,
                    'a list of diagnostics',
                },
            }

            local list = {}
            for _, v in ipairs(diagnostics) do
                local item = {
                    bufnr = v.bufnr,
                    lnum = v.lnum + 1,
                    col = v.col and (v.col + 1) or nil,
                    end_lnum = v.end_lnum and (v.end_lnum + 1) or nil,
                    end_col = v.end_col and (v.end_col + 1) or nil,
                    text = format_diagnostic(v),
                    type = errlist_type_map[v.severity] or 'E',
                }
                table.insert(list, item)
            end
            table.sort(list, function(a, b)
                if a.bufnr == b.bufnr then
                    if a.lnum == b.lnum then
                        return a.col < b.col
                    else
                        return a.lnum < b.lnum
                    end
                else
                    return a.bufnr < b.bufnr
                end
            end)
            return list
        end
    end,
    once = true,
})

--- Create autocmd to keep location list and quickfix list sync with diagnostics
vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = group,
    desc = 'Keep location list in sync with LSP diagnostics',
    --- @param event { buf: number }
    --- @see vim.api.nvim_create_autocmd
    callback = function(event)
        local bufnr = event.buf
        -- Windows of the buffer whose diagnostics changed
        --- @type number[]
        local windows = vim.fn.win_findbuf(bufnr)

        for _, winnr in ipairs(windows) do
            -- Set location-list for the window
            vim.diagnostic.setloclist {
                open = false,
                winnr = winnr,
            }

            -- Check if the location list is empty
            local loc_list = vim.fn.getloclist(winnr)

            -- Location list is not empty, continue
            if #loc_list > 0 then
                return
            end

            --- @type number
            local loc_winnr = vim.fn.getloclist(winnr, { winid = 0 }).winid

            --- Close the location list window when it's visible
            if loc_winnr ~= 0 then
                vim.api.nvim_win_close(loc_winnr, true)
            end
        end
    end,
})

--- Register `.example` files as `sh` filetypes
vim.api.nvim_create_autocmd('BufReadPre', {
    callback = function()
        vim.filetype.add {
            pattern = {
                ['.env.example'] = 'sh',
            },
        }
    end,
    once = true,
})

--- Try to read.nvimrc, .nvim.lua or .exrc whenever CWD changes, like in emacs.
vim.api.nvim_create_autocmd('DirChanged', {
    pattern = 'window',
    group = group,
    callback = function()
        -- Using the current window cwd because of `project.nvim` settings.
        local cwd = vim.fn.getcwd(0)
        local nvimrc_file_names = {
            '.nvim.lua',
            '.nvimrc',
            '.exrc',
        }

        for _, file_name in ipairs(nvimrc_file_names) do
            local full_file_path = cwd .. '/' .. file_name
            if vim.fn.filereadable(full_file_path) == 1 then
                local is_valid = vim.secure.read(full_file_path)
                if is_valid then
                    vim.cmd.source(full_file_path)
                end
                break
            end
        end
    end,
})
