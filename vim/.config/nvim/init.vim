"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"    Andrew Thauer
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:is_nvim = has('nvim')
let g:is_vim8 = v:version >= 800 ? 1 : 0

" ======== XDG Specification ================

if !g:is_nvim && g:is_vim8
  " Set alternative vim locations
  set undodir=$XDG_DATA_HOME/vim/undo
  set directory=$XDG_DATA_HOME/vim/swap
  set backupdir=$XDG_DATA_HOME/vim/backup
  set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo

  " Use the neovim runtime location
  set runtimepath=$XDG_CONFIG_HOME/nvim,$VIMRUNTIME,$XDG_CONFIG_HOME/nvim/after
  let &packpath = &runtimepath
endif

" ======== Plugins ================

source $XDG_CONFIG_HOME/nvim/plugins.vim

" Install vim-plug: https://github.com/junegunn/vim-plug
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" Then Run :PlugInstall in vim

" ======== General Configuration ================

source $XDG_CONFIG_HOME/nvim/config.vim

" ======== Install plugins ================

if empty(glob(expand("$XDG_DATA_HOME/nvim/site/autoload/plug.vim")))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" ======== Other Settings ================

" Load other settings files
for fpath in split(globpath(expand("$XDG_CONFIG_HOME/nvim/init.d"), '*.vim'), '\n')
  exec 'source' fpath
endfor

" Include user's local vim config
if filereadable(expand("$XDG_CONFIG_HOME/nvim/init.local.vim"))
  source $XDG_CONFIG_HOME/nvim/init.local.vim
endif
