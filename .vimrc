" vi: set ft=vim:

" Not compatible with vi (naturally)
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set nobackup            " disable file backups - no one likes junkfiles
set nowrap              " disable line wrap
set smartindent         " intelligently indent while user types
set dir=/tmp            " proper swap file dir
set laststatus=2        " always show status line
set shiftwidth=4        " spaces for [auto]indent
set softtabstop=4       " spaces 1 tab equals
set expandtab           " expand those filthy tabs into proper spaces
set ignorecase          " case insensitivity in searches
set smartcase           " ... unless it looks like I don't want that

" Useful modeline containing filetype, encoding, etc.
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

" Theme, syntax highlighting, and highlighted search for color terms
if &t_Co > 2 || has("gui_running")
  colorscheme elflord
  syntax on
  set hlsearch
endif

" If autocmd was compiled in
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Group up autocmds
  augroup laggrc
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " Jump to last line cursor was on if valid and not first line
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " For dot (graphviz) files that use .gv
  autocmd BufRead,BufNewFile *.gv set filetype=dot

  " For systemd and mysql files
  autocmd BufRead,BufNewFile *.service,*.socket,*.target,my.cnf,.my.cnf set filetype=dosini

  augroup END

else

  " Force autoindent
  set autoindent

endif

" Command to compare your edits to a file since you last saved it
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
