#!/usr/bin/env bash

sudo -v

generate_app "todoist" "https://todoist.com/" --single-instance
generate_app "onenote" "https://www.onenote.com/" --internal-urls "''.*(\\.office\\.com)|(\\.onenote\.com)|(go\\.microsoft\\.com)|(\\.live\\.com).*'"
