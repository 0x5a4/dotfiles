#!/bin/bash

showhelp=0 pacinstall=0 chsh=0 link_files=0
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) showhelp=1; shift ;;
        -i|--pacinstall) pacinstall=1; shift ;;
        -s|--chsh) chsh=1; shift ;;
        -l|--link_files) link_files=1; shift ;;
        -a|--full) pacinstall=1; chsh=1; link_files=1; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if ((showhelp)) ; then
  cat << EOF 
install script for my dotfiles
usage: setup [options]

options:
  -h | --help           show this help
  -i | --pacinstall     install packages
  -s | --chsh           change user shell to fish
  -l | --link_files     link all dotfiles into place
  -a | --full           do everything
EOF
  exit 0
fi

# symlink everything where its supposed to be
if ((link_files)) ; then
  echo "[linking dotfiles]"
  function create_link {
    ln -s $PWD/$1 $HOME/$2
  }
  create_link "vimrc" ".vimrc"
  create_link "starship.toml" ".config/"
  create_link "nvim" ".config/"
  mkdir -p ~/.config/fish
  create_link "fishconf/config.fish" ".config/fish/config.fish"
  create_link "fishconf/conf.d/" ".config/fish/"
  create_link ".tmux.conf" ".tmux.conf"
  create_link ".gitconfig" ".gitconfig"
fi

# install packages
if ((pacinstall)) ; then
  #Arch
  if command -v pacman &> /dev/null; then
    echo "[Installing packages from pkglist]"
    sudo pacman -S --needed - < pkglist
  fi
  #Debian
  if command -v apt-get &> /dev/null; then
    echo "[Installing packages from pkglist]"
    sudo apt-get update 
    xargs -a pkglist sudo apt-get install
  fi

  #Python
  if command -v python3 $> /dev/null; then
    python3 -m pip --user --upgrade pynvim
  fi
fi

if ((chsh)) ; then
  echo "[Changing user shell to fish]"
  command -v fish | xargs sudo chsh $USER -s
fi
