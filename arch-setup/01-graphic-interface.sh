#!/bin/bash

install-sucklesstools(){
  rm -rvf ~/Programs/{dmenu*,dwm*}
  wget https://dl.suckless.org/tools/dmenu-5.0.tar.gz -P ~/Programs
  
  pushd ~/Programs
    tar xvf dmenu-*.tar.gz 
    cd dmenu*/
    cp -rv ~/Programs/dotfiles/sucklesstools/dmenu/* .
    make && sudo make clean install
  popd
  
  if [[ $1 == 1 ]]; then
    wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz -P ~/Programs
    pushd ~/Programs
      tar xvf dwm-*.tar.gz
      cd dwm*/
      cp -rv ~/Programs/dotfiles/sucklesstools/DWM/* .
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
    sudo pacman -S openbox obconf rofi --nocofirm
    ;;
  2)
    echo "install bspwm"
    sudo pacman -S bspwm sxhkd --noconfirm
    install-sucklesstools
    ;;
  3)
    echo "install dwm"
    sudo pacman -S base-devel libx11 libxft libxinerama freetype2 fontconfig --noconfirm
    install-sucklesstools 1
    ;;
  *)
    echo "invalid value"
    exit 1
    ;;
  esac
