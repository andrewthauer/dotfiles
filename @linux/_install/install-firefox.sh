#!/usr/bin/env bash

pushd ~/Downloads > /dev/null
app_name="firefox-developer-edition"
file="$app_name.tar.bz2"
wget -O $file "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"
tar -xvf $file
sudo mv $app_name /opt/$app_name
popd > /dev/nulls
sudo ln -s /opt/$app_name/firefox /usr/local/bin/firefox
sudo cp $app_name.desktop /usr/local/share/applications
