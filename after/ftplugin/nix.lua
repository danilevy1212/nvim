require('config.utils').prequire 'config.filetype.nix'

-- NOTE This is built-in starting nvim 0.10.0
vim.bo.commentstring = "# %s"
vim.bo.comments = ":#"
