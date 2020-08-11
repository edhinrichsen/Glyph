#!/usr/bin/env bash
cd src/Document/
python build_page.py 
cd ../../
meson build --prefix=/usr
cd ./build
ninja
./com.github.edhinrichsen.glyph

