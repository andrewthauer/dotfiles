# mise - https://mise.jdx.dev/installing-mise.html#nushell
mkdir ~/.cache/mise
# ^mise activate nu | save -f ~/.cache/mise/activate.nu
# Workaround for https://github.com/jdx/mise/discussions/6876
(^env -i (which 'mise' | first | get 'path') activate nu) | save --force ~/.cache/mise/activate.nu
