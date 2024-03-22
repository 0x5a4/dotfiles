# 0x5a4's dotfiles

These are my dotfiles, managed using `rcm`(also a Makefile)

## Usage

Run `make <target>`.  
Or maybe run `make PRETEND=1 <target>` first.  
If you find out that all of this has been hacked together by me at 3 am, run `make unmake`.
If you dislike a particular hack, run `make UNMAKE=1 <target>`.

## Software list

- bash
- bspwm
- btop
- fish
- git
- home-manager
- hyprland
- idea vim crap(very dead)
- kitty
- mako
- neovim
- nixos config
- picom
- polybar
- rofi
- starship
- swayidle
- sxhkd
- tmux
- waybar
- wob
- zathura
- zsh(very dead)

### Notes on fish and bash

when run in interactive mode `bash` will just replace itself with fish (see [this](https://wiki.gentoo.org/wiki/Fish#Fish_as_a_default_shell)).
even though `fish` is my preferred shell, scripts from `local/bin` are still written in `bash` because of "compatibility".
`fish`'s functions are mostly used for more fancy aliases and silly things.
