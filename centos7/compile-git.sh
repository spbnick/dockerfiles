#!/bin/bash

mkdir /tmp/git
pushd /tmp/git
  wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.18.0.tar.xz
  tar xf git-2.18.0.tar.xz
  pushd git-2.18.0
    make configure
    ./configure
    make all
    make install
  popd
popd
