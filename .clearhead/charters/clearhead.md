# User-Level Clearhead config
part of good api design is the need to ensure the border between our actual code and the user config used to run it are handled properly.

to do this we need to run it in our own workflow by ensuring that we create initial and sprearheading config/tools that can be used by others.

## Configuration

The first layer is configuring the tool itself like any user so that we are able to run the whole thing end-to-end 

this goes from updating the central user config to actually handling the structure around it to ensure that the experience is ergonomic

this goes for everything from the config of the treesitter formatter, the cli, or the neovim plugin so that we can exercise the tool ourselves

## Integrations

Another key tenent is that we dont want to reinvent the wheel and do things better suited to other tools.

however, this means that we need to also do a small amount of integration work to ensure that everything is going as planned and that we have something that is more akin to a work of structure rather than just a collection of files in a folder
