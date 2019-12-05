#!/usr/bin/env bash

set -e

# Directory of this script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

install_from_brew() {
  brew tap 'InstantClientTap/instantclient'
  brew install 'InstantClientTap/instantclient/instantclient-basic'
  brew install 'InstantClientTap/instantclient/instantclient-sqlplus'
}

install_from_downloads() {
  FULL_VERSION="19.3.0.0.0dbru"
  VERSION="19_3"
  INSTALL_SRC="$HOME/Downloads"
  DEST="$DIR/.local/lib/oracle/instantclient"

  pushd $INSTALL_SRC >/dev/null
  unzip -qq instantclient-basic-macos.x64-$FULL_VERSION.zip
  unzip -qq instantclient-sqlplus-macos.x64-$FULL_VERSION.zip
  popd >/dev/null

  mkdir -p $DEST/bin
  mkdir -p $DEST/lib
  mkdir -p $DEST/jdbc/lib
  mkdir -p $DEST/rdbms/jlib
  mkdir -p $DEST/sqlplus/admin
  mkdir -p $DEST/network/admin

  pushd "$INSTALL_SRC/instantclient_$VERSION" >/dev/null
  mv ojdbc* $DEST/jdbc/lib/
  mv x*.jar $DEST/rdbms/jlib/
  mv glogin.sql $DEST/sqlplus/admin/
  mv *dylib* $DEST/lib/
  mv network/admin/* $DEST/network/admin
  mv *README $DEST/
  mv * $DEST/bin/
  rm -rf $DEST/bin/network
  popd >/dev/null
}

main() {
  install_from_brew
}

main $@
