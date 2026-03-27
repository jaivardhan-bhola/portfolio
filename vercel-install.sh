#!/bin/sh
set -e

if [ -d flutter ]; then
  cd flutter
  git fetch --depth 1 origin stable
  git checkout stable
  cd ..
else
  git clone --depth 1 --branch stable https://github.com/flutter/flutter.git
fi

./flutter/bin/flutter config --enable-web
./flutter/bin/flutter pub get
