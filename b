#!/usr/bin/env bash
meson build --prefix=/usr
cd ./build
ninja
./com.github.edhinrichsen.glyph

