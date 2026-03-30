# Personal Dotfiles

This is a very intimate product, this is my primary config that is meant to be portable between machines.

This means we are both altering the config as well as altering the machine as well

## Big Produts

We have a few big things that we use to manage the structure:
- [chezmoi](https://www.chezmoi.io/) - This is the main product that manages the dotfiles, it is a great product that allows us to manage our dotfiles in a way that is portable between machines.
- [neovim](https://neovim.io/) - This is a great tool for custom configurations and is meant to be portable between machines.
  - [neovide](https://neovide.dev/) - This is a great gui for neovim that allows us to have a more graphical experience with neovim, it is a great product that allows us to have a more graphical experience with neovim.
- [fish](https://fishshell.com/) - We try to keep this relatively minimal but it can be necessary for custom commands and path alterations.
- [tailscale](https://tailscale.com/) - This is a vpn that allows us to connect our machines together in a secure way, it is a great product that allows us to access our machines from anywhere.
- [ghostty](https://ghostty.org/) - our terminal emulator of choice that is modern and gpu accelerated

### Context

Now here is the current state of the machines we need to operate with:

1. the desktop: an arch linux desktop running an nvidia gpu, intel cpu, and is considered the core of the setup
2. tiny server: a small arch machine that is used for testing and as a part of my modular laptop: full amd cpu and gpu combination in a little box
3. the phone: on android we are either running termux or even another arch proot distro to be able to do local-first development on the phone, this is a bit of a stretch but it is a fun experiment to see how far we can take it
4. work laptop: i have a windows machine but it has the windows subsystem for linux so im always going back and forth on how much we should freak out about the windows side or if we just should work entirely from WSL 

#### Pedantic Details

Finally for solid small details, we have fully transitioned to wayland as our backend where relevant. 

and while we have kde and gnome as backup desktop displays, we are really workin with [hyprland](https://hypr.land/) as our primary display manager
