local opt = vim.opt

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

-- Keep indentation of existing lines when autoindenting
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

-- Keep the swap file updated every 50 milis of inactivity
opt.updatetime = 50

-- Use the system clipboard by default
opt.clipboard = 'unnamedplus'

-- Ignore casing when searching a file
opt.wildignorecase = true

-- Set completeopt to have a better completion experience
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Show whitespaces
opt.list = true

-- Chars to show for
opt.listchars = { eol = '↲', tab = '▸ ', space = '·' }

-- Abbreviate commandline messages
opt.shortmess = 'filnxtToOFsS'

-- Abbreviate commandline messages
opt.showmode = false

-- Show the statusline always
opt.laststatus = 2

-- Default diffing options
opt.diffopt = { 'internal', 'filler', 'closeoff', 'linematch:60' }

-- We disallow .nlua files to be loaded if in a directory, if added to ':trust' list.
-- Trusted files are in "$XDG_STATE_HOME/nvim/trust"
-- We do this manually in `after/plugin/autocmd.lua`
opt.exrc = false

-- Set the language to american english
vim.cmd [[language en_US.UTF-8]]

-- editorconfig integration
vim.g.editorconfig = true
