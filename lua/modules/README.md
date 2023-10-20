# Packages

Module that declares all the plugins pulled from third parties. Powered by [Packer](https://github.com/wbthomason/packer.nvim).

## Categories

Plugin specs are separated into the following distinct categories

- Core:

    Foundational and impossible to modularize or lazy load. These plugins set a pattern through-out the codebase and are extensibily used.

- Configuration:
    
    Plugins that offer utility functions or assist with the configuration of neovim.

- Organization:

    Plugins that give some structure to neovim's interactions or help with information gathering.

- Tools:
    
    Plugins that offer an interface to an external programs or interact with external systems outside neovim.

- Editor

    Plugins that facilitate editing text.

- Filetype

    Plugins that target a specific [Filetype](https://neovim.io/doc/user/filetype.html). Further customizations
    can be done in the `after/ftplugin/<filetype>.lua` directory.

- UI

    User interface related plugins. These tend to override the default UI methods shipped with neovim.

## Settings

The settings for each plugin is loaded from the [specs](./specs/) directory.
