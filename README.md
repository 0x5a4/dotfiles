# 0x5a4's dotfiles
These are my dotfiles, managed using `rcm`(also a Makefile)

## Usage
Run `make <target>`.  
Or maybe run `make PRETEND=1 <target>` first.  
If you no longer like something run `make unmake` or `make UNMAKE=1 target`.  

## Software list
- bash
- fish
- git
- hyprland
- idea vim crap(very dead)
- kitty
- mako
- neovim
- picom
- rofi
- starship
- swayidle
- tmux
- waybar
- zathura
- zsh(very dead)

### Notes on fish and bash
`bash` [is configured to just be a wrapper for fish](https://wiki.gentoo.org/wiki/Fish#Fish_as_a_default_shell).  
Scripts from `.local/bin` are still written in `bash` though, because a) "compatibility" and b) i need to learn bash
very badly. `fish`'s functions are mostly used for more fancy aliases and silly things.
