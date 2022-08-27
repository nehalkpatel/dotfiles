
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
" Switch syntax highlighting on, when the terminal has colors
syntax on

" Use system clipboard
" http://stackoverflow.com/questions/8134647/copy-and-paste-in-vim-via-keyboard-between-different-mac-terminals
set clipboard+=unnamed
set pastetoggle=<F2>

set smartcase               " case insensitive matching
set hlsearch                " highlight search results
set incsearch               " search as you type

"" line number
set nu
set foldmethod=syntax
set foldnestmax=10
set nofoldenable

"" Visual elements.
set ruler
set wildmenu
set hlsearch
set nocursorline

"" Tab setting.
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent              " indent a new line the same amount as the line just typed
set smartindent             " smartindent (local to buffer)
set shiftround              " Round to the nearest tabstop

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e

colorscheme primary

" awesome, inserts new line without going into insert mode
map <S-Enter> O<ESC>

" Clear search buffer
:nnoremap § :nohlsearch<cr>

" From mbrochh: Bind nohl Removes highlight of your last search
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Command to use sudo when needed
cmap w!! %!sudo tee > /dev/null %

" File System Explorer (in horizontal split)
map <leader>. :Sexplore<cr>

set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=100                  " set an 80 column border for good coding style
set nobackup                " no need for backup files
set ruler                   " always show the ruler

" Highlight tailing whitespace
" See issue: https://github.com/Integralist/ProVim/issues/4
set list listchars=trail:·,tab:>-

" Make handling vertical/linear Vim windows easier
map <leader>w- <C-W>- " decrement height
map <leader>w+ <C-W>+ " increment height
map <leader>w] <C-W>_ " maximize height
map <leader>w[ <C-W>= " equalize all windows

" Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Reload .vimrc when editing
autocmd! bufwritepost init.vim source %

" specify syntax highlighting for specific files
autocmd Bufread,BufNewFile *.md set filetype=markdown " Vim interprets .md as 'modula2' otherwise, see :set filetype?

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" All of your plugins must be added before the following line.

" Enable file type based indent configuration and syntax highlighting.
" Note that when code is pasted via the terminal, vim by default does not detect
" that the code is pasted (as opposed to when using vim's paste mappings), which
" leads to incorrect indentation when indent mode is on.
" To work around this, use ":set paste" / ":set nopaste" to toggle paste mode.
" You can also use a plugin to:
" - enter insert mode with paste (https://github.com/tpope/vim-unimpaired)
" - auto-detect pasting (https://github.com/ConradIrwin/vim-bracketed-paste)
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting
