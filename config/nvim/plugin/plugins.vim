" Install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Auto-Install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync
  \|   PlugClean
  \|   PlugUpdate --sync
  \|   PlugUpgrade
  \|   q | source $MYVIMRC
  \| endif

" plugins
call plug#begin()

" nerdtree -> ficheiros em árvore
Plug 'scrooloose/nerdtree'

" syntax e afins
Plug 'machakann/vim-highlightedyank'
Plug 'sheerun/vim-polyglot'

" miscellanious
Plug 'tpope/vim-commentary'

call plug#end()

" Nerdtree config
map <F2> :NERDTreeToggle<CR>
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1

" Highlight yank
let g:highlightedyank_highlight_duration = 175
