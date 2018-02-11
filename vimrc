" Optional general settings:
autocmd!              " clears all auto-commands
set paste             " set the paste option for inserting text
set nowrap            " do not wrap long lines
set foldmethod=syntax " fold based on syntax
set foldcolumn=2      " set the fold column space

" In order to use filetype options the following must be present
filetype on
filetype plugin indent on

" Explanation of options used below:
" expandtab replaces any tab keypress with the appropriate number of spaces
" tabstop=2 sets tabs to 2 spaces
" shiftwidth=2 
" softtabstop=2 sets tabs to be spaces
" showmatch highlights matching braces, use % to jump between matching braces
" number shows line numbers
" autoindent does an auto-indent for the next line when indented
" smartindent automatically indents/outdents
" perl_fold automatically folds code between braces

" Required:
autocmd FileType perl set tabstop=2 shiftwidth=2 expandtab softtabstop=2
    
" Optional:
autocmd FileType perl set autoindent smartindent
autocmd FileType perl set showmatch
autocmd FileType perl set number
let perl_fold=1 " needs fold options above

