local opt = vim.opt
local g = vim.g

-- Print the line number in the left fridge
opt.number = true

-- Use relative line numbers
opt.relativenumber = true

-- Tabs displays as four spaces
opt.tabstop = 4

-- Tabs represent four spaces in all other modes
opt.softtabstop = 4

-- Shift indent by four spaces (with '<' or '>')
opt.shiftwidth = 4

-- Tabs is expanded to into spaces in insert mode
opt.expandtab = true

-- Auto indent when possible
opt.autoindent = true

-- Keep indentation of existing lines when auto indenting
opt.copyindent = true

-- Preserve indentation between changes
opt.preserveindent = true

-- Keep an 'undo' file persisted across sessions
opt.undofile = true

-- Enable 24-bit RGB colors in the TUI
opt.termguicolors = true

-- Keep some space between the cursor and the end of the page
opt.scrolloff = 8

-- Draw the sign column always
opt.signcolumn = 'yes'

-- Keep the swap file updated every 50 milliseconds of inactivity
opt.updatetime = 50

-- Use the system clipboard by default
opt.clipboard = 'unnamedplus'

-- Ignore casing when searching a file
opt.wildignorecase = true

-- Set completeopt to have a better completion experience
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Show white spaces
opt.list = true

-- Chars to show for
opt.listchars = { eol = '↲', tab = '▸ ', space = '·' }

-- Abbreviate command line messages
opt.shortmess = 'filnxtToOFsS'

-- Abbreviate command line messages
opt.showmode = false

-- Show the status line always
opt.laststatus = 2

-- Default diffing options
opt.diffopt = { 'internal', 'filler', 'closeoff', 'linematch:60' }

-- We handle this manually in `after/plugin/autocmd.lua`
opt.exrc = false

-- Open vertical splits to the right
opt.splitright = true

-- Small window before the popup apears
vim.opt.timeoutlen = 200

-- Set the language to American English
vim.cmd [[language en_US.UTF-8]]

-- Turn on spell check
opt.spell = true

-- editorconfig integration
g.editorconfig = true

-- Leader and localleader mappings
g.mapleader = ' '
g.maplocalleader = ' m'

-- By default, don't show hidden files in netrw. Can be toggled with `gh`.
g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]
g.netrw_hide = 1

-- Don't show the banner
g.netrw_banner = false

-- Keep the current directory separate from the browsing directory
g.netrw_keepdir = 1
