#!/bin/sh
set -e

FLUTTER_VERSION=3.27.4

if [ -d flutter ]; then
  cd flutter
  git fetch --depth 1 origin tag "$FLUTTER_VERSION"
  git checkout -f "$FLUTTER_VERSION"
  cd ..
else
  git clone --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git
fi

./flutter/bin/flutter config --enable-web
./flutter/bin/flutter pub get
