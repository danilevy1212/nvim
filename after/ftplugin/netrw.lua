-- Don't show spaces in netrw
vim.opt_local.list = false

-- Don't show the banner
vim.g.netrw_banner = false

-- Keep the current directory the same as the browsing directory
vim.g.netrw_keepdir = false

-- By default, don't show hidden files. Can be toggled with `gh`
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]
