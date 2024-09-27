#!/usr/bin/env bash

set -e


# Setup rocksdb
CWD=$(pwd)

system=$(uname -s)

arch=$(uname -m)

out_dir=${CWD}/build/${system}-${arch}

mkdir -p ${out_dir}

cd rocksdb || { echo "directory not found"; exit 1; }

make static_lib

strip librocksdb.a
cp librocksdb.a ${out_dir}

ls -lh ${out_dir}

echo "rocksdb built successfully"
