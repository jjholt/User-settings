# Installation
`git clone git@github.com:jjholt/User-settings.git && cd User-settings`

`./install`

# Neovim setup
After everything has been installed, open nvim and call `:PackerSync` to install the lsp, snippets, etc

# Disable output from bad monitor

1. Go to `/usr/share/pulseaudio/alsa-mixer/paths'`
2. Use Pulse Audio Volume control, `pavu`, to find the exact profile for the controller
3. Change the `.conf` to `.conf.backup`
4. Log out to take effect
