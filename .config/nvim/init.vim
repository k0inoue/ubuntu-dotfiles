" --------------------------------------------------
"  About   : config file for neovim.
"  Author  : k0inoue
"  Update  : 2021.01.10
" --------------------------------------------------
" User environment
" ----------------------------
let s:CONFIG_DIR=empty($XDG_CONFIG_HOME) ? expand("$HOME/.config") : expand($XDG_CONFIG_HOME)
let s:CACHE_DIR=empty($XDG_CACHE_HOME) ? expand("$HOME/.cache") : expand($XDG_CACHE_HOME)
let s:DATA_DIR=empty($XDG_DATA_HOME) ? expand("$HOME/.local/share") : expand($XDG_DATA_HOME)
"execute 'set runtimepath+=' . s:CONFIG_DIR . '/nvim'
let $MYVIMRC=s:CONFIG_DIR . '/nvim/init.vim'
let $MYVIMKEYMAP=s:CONFIG_DIR . '/nvim/keymap.vim'
"let g:python_host_prog='/usr/local/bin/python2.7'
"let g:python3_host_prog='/usr/local/bin/python3.7'
"let g:ruby_host_prog='/usr/local/bin/ruby'

" Basic configs
" ----------------------------
let s:undodir_path=s:CACHE_DIR . '/nvim/undodir'
" make undo history direcotry
if !isdirectory(s:undodir_path)
    call mkdir(s:undodir_path, "p")
    echo "Create undodir to " . s:undodir_path
endif
if isdirectory(s:undodir_path)
    let &undodir=s:undodir_path     " undo history dir
    set undofile                    " undo history on
endif
set nobackup                        " don't make backup file
set novisualbell                    " disable Visual Bell
set history=10000                   " command line history size
set undolevels=1000                 " edit history size
set backspace=indent,eol,start      " allow backspace, for indent, EOL, SOL
set whichwrap=b,s,h,l,<,>,[,]       " allow cusorl move keys, go to next/prev line
set formatoptions=rq                " disable auto break line use 'textwidth'

" indent
set tabstop=4                       " number of spaces replace tab, it looks only
set softtabstop=0                   " number of spaces, push <C-t> when Inser-mode. if 0, use 'tabstop'
set shiftwidth=4                    " number of spaces, when shift indent
set expandtab                       " disable replase spaces to tab
set smarttab                        " use 'shiftwidth'
set shiftround                      " round indent to multiple of 'shiftwidth'

" move dir for open file dir
autocmd BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))

" search / replease / tagjump configs
set incsearch                       " enable incremental search
set gdefault                        " subsutite command g option default
set ignorecase                      " ignore case lower/upper
set smartcase                       " smart case lower/upper
if has('nvim')
    set inccommand=split            " show privew in replace
endif
"set wrapscan                        " enable wrapscan at EOF
if has('path_extra')
    set tags=./tags;$HOME/work      " tags files path
endif

" command-line configs
"set wildmenu                        " command-line completion operates in an enhanced
"set wildmode=longest:full           " complete the next full match(if set wildmenu, also enable)

" window configs
set splitbelow                      " split h window to below of current window
set splitright                      " split v window to right of current window

" fold config
set foldmethod=marker       " auto fold at markers
set foldlevel=100           " not fold when open file

" session configs
set sessionoptions=buffers,folds,resize,sesdir,slash,tabpages

" Display configs
" ----------------------------
set number                          " display line number
set cursorline                      " highlight cursor line
set showbreak=\>>\                  " start of line symbol, if wrraped
set ambiwidth=double                " use twice the width of ASCII characters
set list listchars=tab:>_,trail:_   " show special chars, Tab:>___ / space@EOL:_

" status-line & last-line
set laststatus=2                    " show status line
set showcmd                         " show done command
" status-line format
"  left: [BuffNo.][Readonly][Help][Preview]FilePath[modify]
"  rigth: [FileType][utf-8:unix][currentline/lastline, col]
set statusline=[%n]%r%h%w%F\ %m%=%y\ %{&fenc!=''?&fenc:&enc}\ \|\ %{&ff}\ \|\ %l/%L,%c\"

" color configs
syntax enable
let g:hybrid_custom_term_colors=1
colorscheme hybrid
highlight SpecialKey ctermbg=none ctermfg=darkgray guibg=none guifg=gray
highlight NonText ctermbg=none ctermfg=darkgray guibg=none guifg=gray
highlight Visual ctermbg=53

" change color of cursol-line, when insert mode
highlight CursorLine ctermbg=238 | highlight CursorColumn ctermbg=238
augroup ChangeCursorlLine
  autocmd!
  autocmd InsertEnter * highlight CursorLine ctermbg=94 | highlight CursorColumn ctermbg=94
  autocmd InsertLeave * highlight CursorLine ctermbg=238 | highlight CursorColumn ctermbg=238
augroup END

" highlight for double width space
if has('syntax')
    function! ZenkakuSpace()
        highlight ZenkakuSpace cterm=reverse ctermfg=darkgray gui=reverse guifg=darkgray
    endfunction
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

" IME configs
" ----------------------------
" IME off enter normal mode
set iminsert=0
set imsearch=-1

" IME control command
command! ImeOff silent !imectrl 0
command! ImeOn silent !imectrl 1

function! ImeAutoOff()
    let w:ime_status=system('imests')
    :silent ImeOff
endfunction

function! ImeAutoOn()
    if !exists('w:ime_status')
        let w:ime_status=0
    endif
    if w:ime_status==1
        :silent ImeOn
    endif
endfunction

" IME off when in insert mode
augroup InsertHook
    autocmd!
    autocmd InsertLeave * call ImeAutoOff()
    autocmd InsertEnter * call ImeAutoOn()
augroup END

" Custom function/commands
" ----------------------------
" append files args from quickfix
" Usage: Qargs (when opened quickfix window)
"command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
"function! QuickfixFilenames()
"    let buffer_numbers={}
"    for quickfix_item in getqflist()
"        let buffer_numbers[quickfix_item['bufnr']]=bufname(quickfix_item['bufnr'])
"    endfor
"    return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
"endfunction
"
"" Plugins management with dein
"" ----------------------------
"let s:dein_dir = s:CACHE_DIR . '/nvim/dein'
"let s:conf_toml = s:CONFIG_DIR . '/nvim/dein.toml'
"
"" Install dein
"if &runtimepath !~# '/dein.vim'
"    let s:dein_repo = 'github.com/Shougo/dein.vim'
"    let s:dein_repo_dir = s:dein_dir . '/repos/' . s:dein_repo
"
"    if !isdirectory(s:dein_repo_dir)
"        execute printf('!git clone %s %s', 'https://' . s:dein_repo, s:dein_repo_dir)
"    endif
"
"    execute 'set runtimepath^=' . s:dein_repo_dir
"endif
"
"" Install plugins
"augroup PluginInstall
"    autocmd!
"    autocmd VimEnter * if dein#check_install() | call dein#install() | endif
"augroup END
"
"" Load plugins
"if dein#load_state(s:dein_dir)
"    call dein#begin(s:dein_dir)
"    call dein#load_toml(s:conf_toml)
"    call dein#end()
"    call dein#save_state()
"endif
"
"" Remove plugins
"function PluginRemove()
"    let s:removed_plugins = dein#check_clean()
"    if len(s:removed_plugins) > 0
"        call map(s:removed_plugins, "delete(v:val, 'rf')")
"        call dein#recache_runtimepath()
"    endif
"endfunction
"
"" Update plugins (define command)
"command! -nargs=0 PluginUpdate call dein#update()
"
filetype plugin indent on

" Keymap configs
" ----------------------------
source $MYVIMKEYMAP

