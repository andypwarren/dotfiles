set backspace=indent,eol,start

"
" Silence vim py3 warning
" https://github.com/vim/vim/issues/3117
if has('python3')
  silent! python3 1
endif

" Vim-plug Plugin Manager https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" Theme
Plug 'joshdick/onedark.vim' " (https://github.com/joshdick/onedark.vim)
Plug 'vim-airline/vim-airline' " (https://github.com/vim-airline/vim-airline)

" IDE Features
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'             " Project draw
Plug 'Yggdroot/indentLine'             " Indentation
Plug 'tpope/vim-fugitive'              " Git interface
Plug 'tpope/vim-commentary'            " Code commenting

" Code Completion
Plug 'Valloric/YouCompleteMe', {
    \ 'do': './install.py --clang-completer --gocode-completer --js-completer'
    \ }
Plug 'ervandew/supertab' " For code completion

" Language Support
Plug 'editorconfig/editorconfig-vim'           " Language syntax overrides
Plug 'fatih/vim-go', { 'for': 'go' }           " Go

" Data interchange formats
Plug 'elzr/vim-json' " JSON

" Markup Formats
Plug 'cespare/vim-toml' " TOML

" Initialize plugin system
call plug#end()


"
" General Config
"

" Explicitly set encoding to utf-8
set encoding=utf-8

" Add one virtual space at the end of a line
set virtualedit=onemore

" Syntax Highlighting
syntax on

" Enable indentation
filetype plugin indent on

" Enable line numbers
set number

" Lazy UI/Redraw
set lazyredraw

" Column width indicator
set colorcolumn=+1

" Do not show mode
set noshowmode

" Always show status line
set laststatus=2

" Allow changing buffer without saving
set hidden

" Set to auto read when file is changed elsewhere
set autoread

" Show matching brackets
set showmatch

" Do not conceal
set conceallevel=0

" Show incomplete commands
set showcmd

" Turn back up off
set nobackup
set nowritebackup
set noswapfile

"
" TAB Settings
" TABS are by default set to 4 spaces
"
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab

"
" Text Display Settings
"
set linebreak
set textwidth=0
set wrapmargin=0
set autoindent
set nowrap
set whichwrap+=h,l,<,>,[,]
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

"
" Delete Trailing White Space
"
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

"
" Indent Line
"
let g:indentLine_color_term = 8
let g:indentLine_char = '¦'

"
" VimFiler
"
" <tab> toggles vim filer draw
nnoremap <silent> <tab> :VimFilerExplorer<cr>

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimfiler_draw_files_limit = 1000
let g:vimfiler_ignore_pattern='\%(.cache\|.coverage\|.bat\|.BAK\|.DAT\|.pyc\|.egg-info\)$\|'.
  \ '^\%(.vagrant\)$\|'.
  \ '^\%(.gitkeep\)$\|'.
  \ '^\%(.ebextensions\|.elasticbeanstalk\|Procfile\)$\|'.
  \ '^\%(.git\|.tmp\|__pycache__\|.DS_Store\|.tox\|.idea\|.ropeproject\)$'
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▼'
let g:vimfiler_tree_closed_icon = '▷'
let g:vimfiler_file_icon = '-'
let g:vimfiler_readonly_file_icon = '✕'
let g:vimfiler_marked_file_icon = '❯'
let g:vimfiler_execute_file_list = {'jpg': 'open', 'jpeg': 'open', 'gif': 'open', 'bmp': 'open', 'html': 'open', 'ppt': 'open', 'pdf': 'open', 'png': 'open', 'ico': 'open'}


"
" Vim Airline
"
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline_skip_empty_sections = 0
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline_detect_iminsert=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 1

"
" Go
"
let g:go_fmt_command = 'goimports'
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_auto_type_info = 1
let g:go_term_enabled = 1
let g:go_gocode_unimported_packages = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

"
" JSON
"
let g:vim_json_syntax_conceal = 0

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"
" Theme
"
colorscheme onedark
