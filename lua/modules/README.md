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
    
    Plugins that offer an interface to an external program or interact with external systems outside neovim.

- Editor

    Plugins that facilitate editing text.

## Settings

The settings for each plugin is loaded from the [specs](./specs/) directory.
