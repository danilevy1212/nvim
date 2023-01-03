--- Pulled from https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
        vim.cmd 'packadd packer.nvim'
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
local packer = require 'packer'

--- Wrapper around `packer.use` that sets the spec from the 'modules/settings' directory.
--- @param spec_path string
local function load(spec_path)
    packer.use(require(string.format('modules.specs.%s', spec_path)))
end

return packer.startup {
    -- The loading order is bottom up
    function()

        -- Cold, nice, cozy
        load 'nord'

        -- Fuzzy-search framework
        load 'telescope'

        -- `Project` detection
        load 'project'

        -- Tresitter integration
        load 'treesitter'

        -- Direnv support
        load 'direnv'

        -- Dependency manager in NVIM
        load 'mason'

        -- LSP settings
        load 'lsp'

        -- null-ls
        load 'null-ls'

        -- Autocompletion popup framework
        load 'nvim-cmp'

        -- Surround operator
        load 'surround'

        -- Comment operator
        load 'comment'

        -- Autopairs
        load 'autopairs'

        -- Search todo comments
        load 'todo-comments'

        -- Integration with editorconfig
        load 'editorconfig'

        -- Nvim utility functions
        load 'plenary'

        -- Keymap helper
        load 'which-key'

        -- The package manager
        load 'packer'

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        },
    },
}
