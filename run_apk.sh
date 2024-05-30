#!/bin/bash

SCRIPTPATH="$(
    cd "$(dirname "$0")" >/dev/null 2>&1
    pwd -P
)"
echo "Use path: $SCRIPTPATH/"
cd $SCRIPTPATH

case "$(uname -s)" in
Linux*)
    windows=0
    mac=0
    ;;
Darwin*)
    windows=0
    mac=1
    ;;
CYGWIN*)
    windows=1
    mac=0
    ;;
MINGW*)
    windows=1
    mac=0
    ;;
*)
    windows=0
    mac=0
    ;;
esac

flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter build apk --no-tree-shake-icons
