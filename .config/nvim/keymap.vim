" --------------------------------------------------
"  About   : keymap config file for neovim.
"  Author  : coro
"  Update  : 2020.01.27
" --------------------------------------------------
" Neovim core function
" --------------------------------------------------
" Leader key
" ----------------------------{{{
nnoremap <Space> <nop>
let mapleader="\<Space>"
" }}}

" Read config file
" ----------------------------{{{
nnoremap <silent> <Leader>Cc :<C-u>e $MYVIMRC<CR>
nnoremap <silent> <Leader>Ck :<C-u>e $MYVIMKEYMAP<CR>
nnoremap <silent> <Leader>Cp :<C-u>e ~/.config/nvim/dein.toml<CR>
nnoremap <silent> <Leader>Cr :<C-u>source $MYVIMRC<CR>
" }}}

" Move cursor in normal mode
" ----------------------------{{{
"nnoremap <silent> j  gj
"nnoremap <silent> k  gk
"nnoremap <silent> gj j
"nnoremap <silent> gk k
"vnoremap <silent> j  gj
"vnoremap <silent> k  gk
"vnoremap <silent> gj j
"vnoremap <silent> gk k
" }}}

" Move cursor in command mode
" ----------------------------{{{
cnoremap <C-q> <C-f>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>
" }}}

" Insert mode
" ----------------------------{{{
inoremap <C-d> <Delete>
" }}}

" Help
" ----------------------------{{{
nnoremap <F1> "zyiw:<C-u>help <C-r>z<CR>
vnoremap <F1> "zy:<C-u>help <C-r>z<CR>
autocmd FileType help nnoremap <buffer> q <C-w>c
" }}}

" Man
" ----------------------------{{{
nnoremap K "zyiw:new<CR>:Man <C-R>z<CR>
" }}}

" Quickfix/Location-List
" ----------------------------{{{
" https://thinca.hatenablog.com/entry/20130708/1373210009
function! s:del_qfentry() range
    let qf = getqflist()
    let history = get(w:, 'qf_history', [])
    call add(history, copy(qf))
    let w:qf_history = history
    unlet! qf[a:firstline - 1 : a:lastline - 1]
    call setqflist(qf, 'r')
    execute a:firstline
endfunction
augroup QuickFixLocal
    autocmd!
    autocmd FileType qf nnoremap <buffer> q :<C-u>cclose<CR>
    autocmd FileType qf nnoremap <buffer> dd :<C-u>call <SID>del_qfentry()<CR>
    autocmd FileType qf vnoremap <buffer> d :<C-u>call <SID>del_qfentry()<CR>
    autocmd QuickFixCmdPost make,*grep* cwindow
augroup END
nnoremap <silent> <Leader>qo :<C-u>copen<CR>
nnoremap <silent> <Leader>qq :<C-u>cclose<CR>
nnoremap <silent> <Leader>qu :<C-u>colder<CR>
nnoremap <silent> <Leader>qn :<C-u>cnewer<CR>
nnoremap <silent> <C-k> :<C-u>cprevious<CR>
nnoremap <silent> <C-j> :<C-u>cnext<CR>
nnoremap <C-S-k> :<C-u>cpfile<CR>
nnoremap <C-S-j> :<C-u>cnfile<CR>
" }}}

" Window
" ----------------------------{{{
nnoremap <Leader><Leader>l :<C-u>setlocal wrap!<CR>
" }}}

" Tab
" ----------------------------{{{
nnoremap <silent> <Leader>tn :<C-u>tabnew<CR>
nnoremap <silent> <Leader>tt :<C-u>tabnew `=tempname()`<CR>
nnoremap <silent> <Leader>td :<C-u>tabclose<CR>
"nnoremap <silent> <C-h> :<C-u>tabprevious<CR>
"nnoremap <silent> <C-l> :<C-u>tabnext<CR>
" }}}

" Buffer
" ----------------------------{{{
"nnoremap <silent> <Leader>bj :<C-u>bn<CR>
"nnoremap <silent> <Leader>bk :<C-u>bp<CR>
nnoremap <silent> <Leader>bd :<C-u>bw<CR>
"nnoremap <silent> <Leader>bl :<C-u>ls<CR>
"nnoremap <C-s> :<C-u>w<CR>
" }}}

" Search
" ----------------------------{{{
nnoremap <silent> * *N
nnoremap <silent> # #N
nnoremap <silent> + :%s///gn<CR>
nnoremap <silent> <ESC><ESC> :<C-u>noh<CR>
vnoremap * :<C-u>call <SID>SetSearch(1)<CR>/<C-R>=@/<CR><CR>
vnoremap # :<C-u>call <SID>SetSearch(1)<CR>?<C-R>=@/<CR><CR>
function! s:SetSearch(v_on)
    let temp=@s
    norm! gv"sy
    let @/=substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    if a:v_on == 1
        let @/='\V'.@/
    endif
    let @s=temp
endfunction
" }}}

" Replace
" ----------------------------{{{
nnoremap <Leader>r *``cgn
nnoremap <Leader>R :%s/<C-r><C-a>//c<Left><Left>
vnoremap <Leader>r :<C-u>call <SID>SetSearch(1)<CR>/<C-R>=@/<CR><CR>``cgn
vnoremap <Leader>R :<C-u>call <SID>SetSearch(1)<CR>:<C-u>%s/<C-r>///<Left><Left>
" }}}

" Grep
" ----------------------------{{{
nnoremap <Leader>gp :vimgrep /<C-r><C-a>/j %
" }}}

" Amanll copy & paste
" ----------------------------{{{
nnoremap yA  :1,$y<CR>
nnoremap dA  :1,$d<CR>
" }}}

" Use clipboard
" ----------------------------{{{
"set clipboard+=unnamedplus
nnoremap <Leader>p   "+p
nnoremap <Leader>P   "+P
nnoremap <Leader>y   "+y
nnoremap <Leader>yiw "+yiw
nnoremap <Leader>yi[ "+yi[
nnoremap <Leader>yi( "+yi(
nnoremap <Leader>yi< "+yi<
nnoremap <Leader>yi" "+yi"
nnoremap <Leader>yi' "+yi'
nnoremap <Leader>yi` "+yi`
nnoremap <Leader>y$  "+y$
nnoremap <Leader>yy  "+yy
nnoremap <Leader>ygg :0,.yank +<CR>
nnoremap <Leader>yG  :.,$yank +<CR>
nnoremap <Leader>yA  :0,$yank +<CR>
nnoremap <Leader>d   "+diw
nnoremap <Leader>D   "+d$
nnoremap <Leader>dd  "+dd
nnoremap <Leader>diw "+diw
nnoremap <Leader>di[ "+di[
nnoremap <Leader>di( "+di(
nnoremap <Leader>di< "+di<
nnoremap <Leader>di" "+di"
nnoremap <Leader>di' "+di'
nnoremap <Leader>di` "+di`
nnoremap <Leader>dgg :0,.delete +<CR>
nnoremap <Leader>dG  :.,$delete +<CR>
nnoremap <Leader>dA  :0,$delete +<CR>

vnoremap <Leader>y   "+y
vnoremap <Leader>d   "+d
" }}}

"" hatenablog
"" ----------------------------{{{
"nnoremap <Leader>aa  I[](<ESC>A)<ESC>%i
"nnoremap <Leader>at  I[<ESC>A:title]<ESC>
"nnoremap <Leader>ae  I[<ESC>A:embed]<ESC>
"
"" gist
"" ----------------------------{{{
"nnoremap <Leader>ag  $yT/I[<ESC>A:embed:gist<ESC>pA]<ESC>

" IME
" ----------------------------{{{
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap ｊ j:ImeOff<CR>
nnoremap ｋ k:ImeOff<CR>
nnoremap ｈ h:ImeOff<CR>
nnoremap ｌ l:ImeOff<CR>
nnoremap ：ｗ :w<CR>:ImeOff<CR>
" }}}

"" --------------------------------------------------
"" Neovim plugins
"" --------------------------------------------------
"" kana/vim-submode
"" ----------------------------{{{
"" change window size
"call submode#leave_with('winsize', 'n', '', '<Esc>')
"call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
"call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
"call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
"call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
"call submode#map('winsize', 'n', '', '>', '<C-w>>')
"call submode#map('winsize', 'n', '', '<', '<C-w><')
"call submode#map('winsize', 'n', '', '+', '<C-w>+')
"call submode#map('winsize', 'n', '', '-', '<C-w>-')
"" select buffer
"call submode#leave_with('bufslct', 'n', '', '<Esc>')
"call submode#enter_with('bufslct', 'n', '', '<Leader>bj', ':<C-u>bn<CR>')
"call submode#enter_with('bufslct', 'n', '', '<Leader>bk', ':<C-u>bp<CR>')
"call submode#map('bufslct', 'n', '', 'j', ':<C-u>bn<CR>')
"call submode#map('bufslct', 'n', '', 'k', ':<C-u>bp<CR>')
"" select tab
"call submode#leave_with('tabslct', 'n', '', '<Esc>')
"call submode#enter_with('tabslct', 'n', '', '<Leader>tk', ':<C-u>tabNext<CR>')
"call submode#enter_with('tabslct', 'n', '', '<Leader>tj', ':<C-u>tabnext<CR>')
"call submode#map('tabslct', 'n', '', 'j', ':<C-u>tabnext<CR>')
"call submode#map('tabslct', 'n', '', 'k', ':<C-u>tabNext<CR>')
"" repeat ex-command
"call submode#leave_with('exrepeat', 'n', '', '<Esc>')
"call submode#enter_with('exrepeat', 'n', '', '@@', '@:')
"call submode#map('exrepeat', 'n', '', '@', '@@')
"call submode#map('exrepeat', 'n', '', ';', ';')
"call submode#map('exrepeat', 'n', '', ',', ',')
"call submode#map('exrepeat', 'n', '', 'j', 'j')
"call submode#map('exrepeat', 'n', '', 'k', 'k')
"call submode#map('exrepeat', 'n', '', 'n', 'n')
"call submode#map('exrepeat', 'n', '', 'N', 'N')
"" }}}
"" mbbill/undotree
"" ----------------------------{{{
"nnoremap <Leader>u :UndotreeToggle<CR>
""function! g:Undotree_CustomMap()
""    map <silent> <buffer> h ?
""endfunction
"" }}}
"
"" unblevable/quick-scope
"" ----------------------------{{{
"nnoremap <leader>q <plug>(QuickScopeToggle)
"xnoremap <leader>q <plug>(QuickScopeToggle)
"" }}}
"
"" SirVer/ultisnips
"" ----------------------------{{{
"let g:UltiSnipsExpandTrigger="<C-j>"
"let g:UltiSnipsJumpForwardTrigger="<C-k>"
"let g:UltiSnipsJumpBackwardTrigger="<C-K>"
"" }}}
"
"" svermeulen/vim-yoink
"" ----------------------------{{{
"nmap <c-n> <plug>(YoinkPostPasteSwapBack)
"nmap <c-p> <plug>(YoinkPostPasteSwapForward)
"nmap p <plug>(YoinkPaste_p)
"nmap P <plug>(YoinkPaste_P)
"nmap y <plug>(YoinkYankPreserveCursorPosition)
"xmap y <plug>(YoinkYankPreserveCursorPosition)
"nmap <c-=> <plug>(YoinkPostPasteToggleFormat)
"nnoremap yc :<C-u>ClearYanks<CR>
"nnoremap yv :<C-u>Yanks<CR>
"" }}}
"
"" terryma/vim-expand-region
"" ----------------------------{{{
"vmap + <Plug>(expand_region_expand)
"vmap - <Plug>(expand_region_shrink)
"" }}}
"
"" junegunn/fzf.vim
"" ----------------------------{{{
"nnoremap <C-s>e  :Files 
"nnoremap <C-s>h  :History<CR>
"nnoremap <C-s>:: :History:<CR>
"nnoremap <C-s>:/ :History/<CR>
"nnoremap <C-s>gl :GFiles<CR>
"nnoremap <C-s>gs :GFiles?<CR>
"nnoremap <C-s>gc :Commits<CR>
"nnoremap <C-s>b  :Buffers<CR>
"nnoremap <C-s>w  :Windows<CR>
"nnoremap <C-s>m  :Marks<CR>
"nnoremap <C-s>k  :Maps<CR>
"nnoremap <C-s>f  :Filetypes<CR>
"nnoremap <C-s>t  :Tags<CR>
"nnoremap <C-s>cl :Colors<CR>
"nnoremap <C-s>cm :Commands<CR>
"nnoremap <C-s>/  :BLines 
"nnoremap <C-s>*  :BLines <C-r><C-a><CR>
"vnoremap <C-s>*  :<C-u>call <SID>SetSearch(0)<CR>:<C-u>BLines <C-r>=@/<CR>
"nnoremap <C-s>gg :Rg 
"nnoremap <C-s>g* :Rg <C-r><C-a><CR>
"vnoremap <C-s>g  :<C-u>call <SID>SetSearch(0)<CR>:<C-u>Rg <C-r>=@/<CR>
"" }}}
"
"" t9md/vim-quickhl
"" ----------------------------{{{
"" highlight on/off for target word
"nnoremap <Leader>: :<C-u>call quickhl#cword#toggle()<CR>
"
"" highlight on/off for tags word
"nnoremap <Leader>] :<C-u>call quickhl#tag#toggie('v')<CR>
"
"" highlight cursol/selected word
"nnoremap <Leader>; :<C-u>call quickhl#manual#this('n')<CR>
"vnoremap <Leader>; :<C-u>call quickhl#manual#this('v')<CR>
"nnoremap <Leader>+ :<C-u>call quickhl#manual#clear_this('n')<CR>
"vnoremap <Leader>+ :<C-u>call quickhl#manual#clear_this('v')<CR>
"
"" clear highlight
"nnoremap <Leader><Esc> :<C-u>call quickhl#manual#reset()<CR>
"
"" list of highlight words
"nnoremap <Leader>* :<C-u>call quickhl#manual#list()<CR>
"" }}}
"
"
"" easymotion/vim-easymotion
"" ----------------------------{{{
"" `s{char}{char}{label}`
""nmap s <Plug>(easymotion-overwin-f)
"nmap s <Plug>(easymotion-overwin-f2)
"omap / <Plug>(easymotion-overwin-f)
"map  <Leader>/ <Plug>(easymotion-sn)
"
"" Gif config
"map <Leader>sl <Plug>(easymotion-lineforward)
"map <Leader>sj <Plug>(easymotion-j)
"map <Leader>sk <Plug>(easymotion-k)
"map <Leader>sh <Plug>(easymotion-linebackward)
"
"let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
"
"" JK motions: Line motions
""map <Leader>j <Plug>(easymotion-j)
""map <Leader>k <Plug>(easymotion-k)
"" }}}
"
"" mattn/vim-maketable
"" ----------------------------{{{
"nnoremap <Leader>mt V}k:MakeTable! ,\ <CR>
"nnoremap <Leader>mT :UnmakeTable ,\ <CR>
"" }}}
"
"" n04ln/diesirae.nvim
"" ----------------------------{{{
"nnoremap <Leader>aojl :<C-u>AojSession<CR>
"nnoremap <Leader>aojs i"<C-x><C-f>"<Esc>"zda"u:<C-u>call AojSubmit(<C-r>z)
"nnoremap <Leader>aojt i"<C-x><C-f>"<Esc>"zda"u:<C-u>call AojRunSample(<C-r>z)
"" }}}
"
"" thinca/vim-quickrun
"" ----------------------------{{{
"nnoremap <F5>n :<C-u>QuickRun<CR>
"nnoremap <F5>i :<C-u>QuickRun < 
"" single:-args myarg  multi:-args "arg1 arg2"
"nnoremap <F5>k :<C-u>QuickRun -args ""<Left>
"" }}}
"
"" autozimu/LanguageClient-neovim
"" ----------------------------{{{
"function! LC_map()
"    if has_key(g:LanguageClient_serverCommands, &filetype)
"        nnoremap <silent> <F3>  :call LanguageClient#contextMenu()<CR>
"        nnoremap <silent> K     :call LanguageClient#textDocument_hover()<CR>
"        nnoremap <silent> gd    :call LanguageClient#textDocument_definition()<CR>
"        nnoremap <silent> <F2>  :call LanguageClient#textDocument_rename()<CR>
"        nnoremap <silent> <F4>  :call LanguageClient#textDocument_formatting()<CR>
"    endif
"endfunction
"" }}}
"
"" keymap on filetype go
"" ----------------------------{{{
"augroup Go_keymap
"    autocmd!
"    " sebdah/vim-delve
"    autocmd BufEnter *.go nnoremap <silent> <F6>  :<C-u>DlvDebug<CR>
"    autocmd BufEnter *.go nnoremap <silent> <F9>  :<C-u>DlvToggleBreakpoint<CR>
"    autocmd BufEnter *.go nnoremap <silent> <S-F9>  :<C-u>DlvToggleTracepoint<CR>
"
"    " mattn/vim-goimpl
"    " :GoImple ReciverType  StructType
"    autocmd BufEnter *.go nnoremap <Leader>gi  :<C-u>GoImpl 
"augroup END
"" }}}
"
