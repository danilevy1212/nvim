# Introduction

Plugins are declared in this module. Powered by [lazy](https://github.com/folke/lazy.nvim).

## Specs

Specs are defined in the `specs` directory. These files tell lazy how to load the plugin. The specs are divided into the following categories:

###  Categories

Plugin specs are separated into the following distinct categories

- **libraries:** Plugins that provide a set of functions or utilities that can be used by other plugins.

- **meta:** Plugins that help with the management of other executables, plugins or configuration of neovim itself.

- **organization:** Plugins that give some structure to neovim's interactions or help with information gathering.

- **tools:** Plugins that offer an interface to an external programs or interact with external systems outside neovim.

- **editor:** Plugins that facilitate editing text.

- **filetype:** Plugins that target a specific [Filetype](https://neovim.io/doc/user/filetype.html). Further customizations
    can be done in the `after/ftplugin/<filetype>.lua` directory.

- **ui:** User interface related plugins. These override the default UI methods shipped with neovim.

## Local plugins

Local plugins are plugins that are stored locally in the `~/.config/nvim/lua/dan/plugins/local` directory. Local plugins allow to reuse the lazy mechanisms to load local files, as long as there is a spec that references them, allowing to abstract part of the configuration as just another plugin that can be lazy loaded whenever we need it.

Local plugins contain `dan` as the namespace in their spec. See [init.lua](./init.lua) for details.
