" ================ ALE ====================
" https://github.com/w0rp/ale

" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['prettier', 'eslint', 'tslint', 'typescript']

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
