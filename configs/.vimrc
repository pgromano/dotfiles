" ============================================================
" General Settings
" ============================================================
syntax on
set encoding=utf-8
set nocompatible
set history=1000
set autoread                    " reload files changed outside vim

" ============================================================
" UI
" ============================================================
set number                      " line numbers
" set relativenumber              " relative line numbers (great for jumps)
set ruler
set showcmd
set showmatch                   " highlight matching brackets
set cursorline                  " highlight current line
set scrolloff=8                 " keep 8 lines above/below cursor
set colorcolumn=88              " PEP8-ish column marker (black uses 88)
set signcolumn=yes              " always show sign column (for linting etc.)
set nowrap

" ============================================================
" No folding, ever
" ============================================================
set nofoldenable
set foldlevel=99

" ============================================================
" Search
" ============================================================
set incsearch
set hlsearch
set ignorecase
set smartcase                   " case-sensitive if query has uppercase
nnoremap <esc> :noh<return><esc> " clear search highlight with Escape

" ============================================================
" Indentation
" ============================================================
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

augroup filetype_overrides
    autocmd!
    " C++ uses 2-space indent (common in ML codebases like TF/JAX)
    autocmd BufNewFile,BufRead *.cpp,*.cc,*.h,*.hpp
        \ set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=100
    " Bash
    autocmd BufNewFile,BufRead *.sh
        \ set tabstop=2 softtabstop=2 shiftwidth=2
    " Python
    autocmd BufNewFile,BufRead *.py
        \ set textwidth=88 fileformat=unix
augroup END

autocmd FileType make setlocal noexpandtab

" Map Option + direction to move back and forth between words
inoremap \033b <C-o>b

