

Configuring Neovim is probably our primary focus as far as keeping a dotfile configuration goes.

Neovim is the beating heart at the center of the configuration, and undergoes rapid changes in configuration and the technologies used within the stack since the velocity of the Neovim application itself is so high.
- This means that we have to put extra work into ensuring the configuration is both robust enough to do what we want to do.
- While also keeping up engineering practices that can keep it productive while I use it as a work product.

# LazyVim Init

I finally settled my horses with LazyVim for reasons that you can explore within the main knowledge base as to what it delivers over stock neovim.

One of the benefits of lazyvim is the ease of setup, our init file is literally just:
``` lua
require("config.lazy")
```
- all this file does is source the file located in `lua/config/lazy.lua` where the primary configuration for Lazy.nvim is located
    - Since Lazy is the engine of the configuration, all we need to do is ensure this is able to be loaded on startup
        - if done properly, it will even setup new machines properly if all of the dependencies are already worked out!

# [Neovim Base Config](#configmd)


# [Plugins Config](#pluginsmd)

