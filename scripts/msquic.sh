#!/usr/bin/env bash

set -e

CWD=$(pwd)

system=$(uname -s)

arch=$(uname -m)

out_dir=${CWD}/build/${system}-${arch}

mkdir -p ${out_dir}

cd msquic || { echo "Submodule directory not found"; exit 1; }

rm -rf build

mkdir build && cd build

if [ $system = "Darwin" ]; then
    cmake -DENABLE_LOGGING=OFF  -DCMAKE_OSX_ARCHITECTURES=$arch -DCMAKE_C_FLAGS="-Wno-invalid-unevaluated-string" -DQUIC_BUILD_SHARED=off ..
elif [ $system = "Linux" ]; then
    cmake -G 'Unix Makefiles' -DENABLE_LOGGING=OFF  -DCMAKE_OSX_ARCHITECTURES=$arch -DCMAKE_C_FLAGS="-Wno-invalid-unevaluated-string" -DQUIC_BUILD_SHARED=off ..
fi

cmake --build . || { echo "Build msquic library failed"; exit 1; }

cp bin/Release/libmsquic.a ${out_dir}

echo "msquic built successfully"
