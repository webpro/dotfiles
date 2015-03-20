" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Once you've updated the list of plugin, you can run vundle update by issuing
" the command :BundleInstall from within vim or directly invoking it from the
" command line with the following syntax:
" vim --noplugin -u vim/vundles.vim -N "+set hidden" "+syntax on" +BundleClean! +BundleInstall +qall
" Filetype off is required by vundle

filetype off

set rtp+=$HOME/.vim/bundle/vundle/
call vundle#begin("$HOME/.vim/bundle")

" let Vundle manage Vundle (required)

Bundle "gmarik/vundle"

" Generic

Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Bundle "itchyny/lightline.vim"
Plugin 'terryma/vim-multiple-cursors'
Bundle 'rking/ag.vim'

" Git

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Syntax hightlighting & colors

Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'

" Completion & snippets

Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" JavaScript

Bundle "pangloss/vim-javascript"
Plugin 'marijnh/tern_for_vim'

" Other

Plugin 'tpope/vim-markdown'
Plugin 'mattn/emmet-vim'

call vundle#end()

"Filetype plugin indent on is required by vundle
filetype plugin indent on
