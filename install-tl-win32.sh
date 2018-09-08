#!/bin/bash

set -e

DIRNAME=tl-`date +%Y_%m_%d_%H_%M_%S`

echo "make the install directory: $DIRNAME"
mkdir $DIRNAME
cd $DIRNAME
curl -O http://mirror.ctan.org/systems/texlive/tlnet/install-tl.zip
unzip install-tl.zip
cd install-tl-*
cat << EOF > ./fullinst.profile
selected_scheme scheme-full
TEXDIR /texlive
TEXMFCONFIG /.texlive/texmf-config
TEXMFHOME /texmf
TEXMFLOCAL /texlive/texmf-local
TEXMFSYSCONFIG /texlive/texmf-config
TEXMFSYSVAR /texlive/texmf-var
TEXMFVAR /.texlive/texmf-var
binary_win32 1
EOF
echo y | ./install-tl-windows.bat -profile ./fullinst.profile -repository http://mirror.ctan.org/systems/texlive/tlnet/
tlmgr.bat init-usertree
cd ../..
echo "remove the install directory"
rm -rf $DIRNAME

