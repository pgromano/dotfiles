" ============================================================
" General Settings
" ============================================================
syntax on
set encoding=utf-8
set nocompatible
set history=1000
set autoread

" ============================================================
" UI
" ============================================================
set number
set ruler
set showcmd
set showmatch
set cursorline
set scrolloff=8
set colorcolumn=88
set nowrap
set laststatus=2

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
set smartcase
nnoremap <esc> :noh<return><esc>

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
    autocmd BufNewFile,BufRead *.cpp,*.cc,*.h,*.hpp
        \ set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=100
    autocmd BufNewFile,BufRead *.sh
        \ set tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.py
        \ set textwidth=88 fileformat=unix
augroup END

autocmd FileType make setlocal noexpandtab

" ============================================================
" Plugins (vim-plug)
" Install: curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Run :PlugInstall after saving
" ============================================================
call plug#begin('~/.vim/plugged')

Plug '/opt/homebrew/opt/fzf'        " Homebrew fzf binary (Apple Silicon)
" Plug '/usr/local/opt/fzf'         " uncomment instead if Intel Mac
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-commentary'
Plug 'joshdick/onedark.vim'

call plug#end()

" ============================================================
" Colors
" ============================================================
colorscheme onedark
"set background=dark

" ============================================================
" Status line (built-in, no plugin)
" ============================================================
set statusline=
set statusline+=\ %{toupper(mode())}
set statusline+=\ \|\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%y
set statusline+=\ %l:%c
set statusline+=\ \|\ %p%%\ 

" ============================================================
" FZF
" ============================================================
nnoremap <C-p>  :Files<CR>
nnoremap <C-b>  :Buffers<CR>
nnoremap <D-f>  :BLines<CR>
nnoremap <leader>f :Rg<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.fzf#shellescape(<q-args>),
  \   fzf#vim#with_preview(),
  \   <bang>0)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" ============================================================
" LSP
" ============================================================
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nnoremap <buffer> gd          <plug>(lsp-definition)
    nnoremap <buffer> gD          <plug>(lsp-declaration)
    nnoremap <buffer> gr          <plug>(lsp-references)
    nnoremap <buffer> K           <plug>(lsp-hover)
    nnoremap <buffer> <F2>        <plug>(lsp-rename)
    nnoremap <buffer> [d          <plug>(lsp-previous-diagnostic)
    nnoremap <buffer> ]d          <plug>(lsp-next-diagnostic)
    nnoremap <buffer> <leader>ca  <plug>(lsp-code-action)
    nnoremap <buffer> gi          <plug>(lsp-implementation)
endfunction

augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" ============================================================
" Completion
" ============================================================
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" ============================================================
" Git
" ============================================================
let g:gitgutter_enabled = 1
nnoremap <leader>hp <plug>(GitGutterPreviewHunk)
nnoremap <leader>hs <plug>(GitGutterStageHunk)
nnoremap <leader>hu <plug>(GitGutterUndoHunk)
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>

" ============================================================
" Multi-cursor (vim-visual-multi)
" ============================================================
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps['Add Cursor Up']      = '<C-S-Up>'
let g:VM_maps['Add Cursor Down']    = '<C-S-Down>'

" ============================================================
" macOS navigation
" Option+Arrow        → move by word
" Shift+Option+Arrow  → select by word
" Cmd+Arrow           → jump to start/end of line
" Cmd+Shift+Arrow     → select to start/end of line
" ============================================================
noremap  <M-Right>   w
noremap  <M-Left>    b
inoremap <M-Right>   <C-o>w
inoremap <M-Left>    <C-o>b

nnoremap <S-M-Right> vE
nnoremap <S-M-Left>  vB
vnoremap <S-M-Right> E
vnoremap <S-M-Left>  B

noremap  <D-Right>   $
noremap  <D-Left>    ^
inoremap <D-Right>   <C-o>$
inoremap <D-Left>    <C-o>^

nnoremap <D-S-Right> v$
nnoremap <D-S-Left>  v^
vnoremap <D-S-Right> $
vnoremap <D-S-Left>  ^

" ============================================================
" Splits
" ============================================================
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
