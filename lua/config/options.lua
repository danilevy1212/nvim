--- Helper function to set an opt globally
--- @param option string
--- @param val any
_G.seto = function(option, val)
    vim.opt[option] = val
end

-- Print the line number in the left fridge
seto('number', true)

-- Use relative line numbers
seto('relativenumber', true)

-- Tabs displays as four spaces
seto('tabstop', 4)

-- Tabs represent four spaces in all other modes
seto('softtabstop', 4)

-- Shift indent by four spaces (with '<' or '>')
seto('shiftwidth', 4)

-- Tabs is expanded to into spaces in insert mode
seto('expandtab', true)

-- Auto indent when possible
seto('autoindent', true)

-- Keep indentation of existing lines when autoindenting
seto('copyindent', true)

-- Preserve indentation between changes
seto('preserveindent', true)

-- Keep an 'undo' file persisted across sessions
seto('undofile', true)

-- Enable 24-bit RGB colors in the TUI
seto('termguicolors', true)

-- Keep some space between the cursor and the end of the page
seto('scrolloff', 8)

-- Draw the sign column always
seto('signcolumn', 'yes')

-- Keep the swap file updated every 50 milis of inactivity
seto('updatetime', 50)

-- Use the system clipboard by default
seto('clipboard', 'unnamedplus')

-- Ignore casing when searching a file
seto('wildignorecase', true)

-- Set completeopt to have a better completion experience
seto('completeopt', { 'menu', 'menuone', 'noselect' })

-- Show whitespaces
seto('list', true)

-- Chars to show for
seto('listchars', { eol = '↲', tab = '▸ ', space = '·' })

-- Set the language to american english
vim.cmd [[language en_US.UTF-8]]
