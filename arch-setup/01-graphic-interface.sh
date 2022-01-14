#!/bin/bash

install-sucklesstools(){
  wget https://dl.suckless.org/tools/dmenu-5.0.tar.gz -P ~/Programs
  
  pushd ~/Programs
    tar xvf dmenu-*.tar.gz 
    cd dmenu*/
    cp ~/Programs/dotfiles/sucklesstools/dmenu/* .
    make && sudo make clean install
  popd
  
  if [[ $1 == 1 ]]; then
    wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz -P ~/Programs
    pushd ~/Programs
      tar xvf dwm-*.tar.gz
      cd dwm*/
      cp ~/Programs/dotfiles/sucklesstools/DWM/* .
      make && sudo make clean install
    popd
  fi
}

if  [ ! -d ~/Programs/dotfiles ]; then 
  git clone https://github.com/Shoyo-0kbps/dotfiles ~/Programs/dotfiles
fi

MENU="
1 - openbox
2 - bspwm
3 - dwm
"
echo $MENU
read -p "Option: " OPTION

case "$OPTION" in 
  1)
    echo "install openbox"
    yes | sudo pacman -S openbox obconf rofi
    ;;
  2)
    echo "install bspwm"
    yes | sudo pacman -S bspwm sxhkd
    install-sucklesstools
    ;;
  3)
    echo "install dwm"
    yes | sudo pacman -S base-devel libx11 libxft libxinerama freetype2 fontconfig
    install-sucklesstools 1
    ;;
  *)
    echo "invalid value"
    exit 1
    ;;
  esac