#!/bin/bash

LLVM_CONFIG=llvm-config-21

cd /mnt/apps/toolchain/Odin
git pull
./build_odin.sh release-native

cd /mnt/apps/toolchain/lsp/ols
git pull
./build.sh
