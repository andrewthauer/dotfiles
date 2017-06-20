" =========== NeoBundle Core ============

let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
  let g:not_finsh_neobundle = "yes"

  " Run shell script if exist on custom select language
  silent !\curl -sSL https://raw.githubusercontent.com/avelino/vim-bootstrap/master/vim_template/langs/python/python.sh | bash -s stable
  silent !\curl -sSL https://raw.githubusercontent.com/avelino/vim-bootstrap/master/vim_template/langs/javascript/javascript.sh | bash -s stable
  silent !\curl -sSL https://raw.githubusercontent.com/avelino/vim-bootstrap/master/vim_template/langs/ruby/ruby.sh | bash -s stable
  silent !\curl -sSL https://raw.githubusercontent.com/avelino/vim-bootstrap/master/vim_template/langs/html/html.sh | bash -s stable
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
