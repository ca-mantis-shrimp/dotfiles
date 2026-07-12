# Neovim Config

This configuration attempts to configure the neovim editor using modern best-practices and making our own custom developer environment.

With that, we always try to use OOTB neovim capabilities where possible or using the plugins that are most impactful

## Core Dependencies

Now, we do actually take advantage of some plugins that will really help understand how this works:

- [lazy.nvim](https://github.com/folke/lazy.nvim) is our package manager for now
- [nfnl](https://github.com/Olical/nfnl) our fennel-lua compiler that will actually structure the work that we are using 

We will go over the rest but these are the deps that change how to understand the structure. nfnl confers all of the fennel files into lua so one should always edit the fennel files while allowing nfnl to do what is needed to generate these new lua files
## Anatomy

So we have a few large sections:

- `ftplugin` are individual files that configure the system for specific files with each file name corresponding to the filetype they pertain to
- [init](./init.fnl)
- `lua` is where the bulk of the config is 
