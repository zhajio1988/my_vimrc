"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""modified by zhajio"""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"define prefix of shortcut key, as well as <Leader>
let mapleader = "\\"

execute pathogen#infect()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""runtimepath  fzf doesn't work
set rtp+=~/.fzf 
call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

let g:fzf_launcher = 'gnome-terminal --hide-menubar --disable-factory -x bash -ic %s'
""""""""""""""""""""<color scheme setting>""""""""""""""""""
""vim color scheme setting 
if has("gui_running")
    set background=dark
    colorscheme desert    
    "colorscheme solarized
else
    colorscheme molokai
endif

""""""""""""""""""some useful plugins setting"""""""""""""""
""""""""""""""""""""""""<tag_list>""""""""""""""""""""""""""
""let Tlist_Show_One_File=1
""let Tlist_Exit_OnlyWindow=1
""let Tlist_Use_Right_Window=1
""nmap <silent> <F4> :TlistToggle<CR>

" OmniCppComplete
""filetype plugin on
""set completeopt=menuone,menu
""let OmniCpp_MayCompleteDot=1 
""let OmniCpp_MayCompleteArrow=1 
""let OmniCpp_MayCompleteScope=1
""let OmniCpp_NamespaceSearch=1
""let OmniCpp_GlobalScopeSearch=1
""let OmniCpp_DefaultNamespaces=["std"]
""let OmniCpp_ShowPrototypeInAbbr=1 
""let OmniCpp_SelectFirstItem = 2
""" automatically open and close the popup menu / preview window
""au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
""
""highlight Pmenu    guibg=darkgrey  guifg=black
""highlight PmenuSel guibg=lightgrey guifg=black

set cscopetag

""""""""""""""""""""""""<win_manager>""""""""""""""""""""""""""
let g:winManagerWindowLayout='FileExplorer'
nmap wm :WMToggle<cr>

""""""""""verilog systemverilog mode"""""""""""""""""""""""""""
""nnoremap <leader>i :VerilogFollowInstance<CR>
""nnoremap <leader>I :VerilogFollowPort<CR>
""nnoremap <leader>u :VerilogGotoInstanceStart<CR>
"
""supertab
let g:SuperTabDefaultCompletionType = 'context'
""let g:SuperTabRetainCompletionType = 2
""let g:SuperTabDefaultCompletionType = "<C-X><C-O>" 
""tagbar
let g:tagbar_ctags_bin='~/bin/exctags'
let g:tagbar_autofocus = 1
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_type_systemverilog = {
        \ 'ctagstype'   : 'SystemVerilog',
        \ 'kinds'       : [
            \ 'b:blocks:1:1',
            \ 'c:constants:1:0',
            \ 'e:events:1:0',
            \ 'f:functions:1:1',
            \ 'm:modules:0:1',
            \ 'n:nets:1:0',
            \ 'p:ports:1:0',
            \ 'r:registers:1:0',
            \ 't:tasks:1:1',
            \ 'A:assertions:1:1',
            \ 'C:classes:0:1',
            \ 'V:covergroups:0:1',
            \ 'I:interfaces:0:1',
            \ 'M:modport:0:1',
            \ 'K:packages:0:1',
            \ 'P:programs:0:1',
            \ 'R:properties:0:1',
            \ 'T:typedefs:0:1'
    \ ],
        \ 'sro'         : '.',
        \ 'kind2scope'  : {
            \ 'm' : 'module',
            \ 'b' : 'block',
            \ 't' : 'task',
            \ 'f' : 'function',
            \ 'C' : 'class',
            \ 'V' : 'covergroup',
            \ 'I' : 'interface',
            \ 'K' : 'package',
            \ 'P' : 'program',
            \ 'R' : 'property'
        \ },
    \ }

""""""""""""""""""""""""""<minibuf>""""""""""""""""""""""""""""
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplMapWindowsNavVim=1
let g:miniBufExplMapWindowNavArrows=1
""""""""""""""""""""""""""<EasyMotion>""""""""""""""""""""""""""""
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
map <Leader><leader>. <Plug>(easymotion-repeat)
""""""""""""""""""""""""""<localrc>""""""""""""""""""""""""""""
let g:localrc_filename = '.uvmrc'
let g:uvm_email = "jude.zhang@analog.com"

""""""""""""""""""""""""""<multiple-cursors>""""""""""""""""""""""""""""
"let g:multi_cursor_use_default_mapping=0

" Default mapping
""let g:multi_cursor_start_word_key      = '<C-n>'
""let g:multi_cursor_select_all_word_key = '<A-n>'
""let g:multi_cursor_start_key           = 'g<C-n>'
""let g:multi_cursor_select_all_key      = 'g<A-n>'
""let g:multi_cursor_next_key            = '<C-n>'
""let g:multi_cursor_prev_key            = '<C-p>'
""let g:multi_cursor_skip_key            = '<C-x>'
"let g:multi_cursor_quit_key            = '<Esc>'

""""""""""""""""""""""""""<Tabularize>""""""""""""""""""""""""""""
if exists(":Tabularize")
    nmap <Leader>t= :Tabularize /=<CR>
    vmap <Leader>t= :Tabularize /=<CR>
    nmap <Leader>t: :Tabularize /:\zs<CR>
    vmap <Leader>t: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction
""""""""""""""""""""""""""<matchit>""""""""""""""""""""""""""""
let g:hl_matchit_enable_on_vim_startup = 1
let b:match_words='\<begin\>:\<end\>,'
            \.'\<class\>:\<endclass\>,'
            \.'\<task\>:\<endtask\>,'
            \.'\<fork\>:\<join\>,'
            \.'\<fork\>:\<join_any\>,'
            \.'\<fork\>:\<join_none\>,'
            \.'\<function\>:\<endfunction\>,'
            \.'\<case\>:\<endcase\>,'
            \.'\<module\>:\<endmodule\>,'
            \.'\<block\>:\<endblock\>,'
            \.'\<covergroup\>:\<endgroup\>,'
            \.'\<if\>:\<endif\>,'

""""""""""""""""""""abbreviations""""""""""""""""""""""""""""""""""
"such as you can use dpb represent debug point
ab //b //----------------------------------------------------------
ab #b ############################################################
ab *b #**********************************************************
ab zjemail zhajio.1988@gamil.com
ab dp debug point
ab /b ///< 

""""""""""""""""""ctags list"""""""""""""""""""""""""""
let $project_name = $PRJ_NAME
set tags+=~/ctags/uvm_tags
set tags+=~/ctags/jesd_tags
set tags+=~/ctags/soc_vv_tags
set tags+=~/ctags/vip_tags
set tags+=~/ctags/eth_tags
set tags+=~/ctags/hwa_tags
set tags+=~/ctags/soc_fw_tags
set tags+=~/ctags/andes_tags
set tags+=~/ctags/fhi_tags
set tags+=~/ctags/ot_tags
set tags+=~/ctags/pal_tags
set tags+=~/ctags/fw_tags
set tags+=~/ctags/hwal_tags
set tags+=./tags
if $project_name =~ 'll'
endif

""""""""""""""""""Auto complete"""""""""""""""""""""""""""
set complete=.,w,i,b,u,d,k
set dictionary=~/.vim/words/uvm_kwords,$VCS_HOME/gui/tb/qdbg_sv.ini,/usr/share/dict/words
set isfname+={,}
set isfname-=,
""""""""""""""""""""""<gui_font_setting>""""""""""""""""""
set linespace=1
if has("gui_running")
        if has("gui_gtk2")
                ":set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
                ":set guifont=Courier\ 16,mendium\ 16
                ":set guifont=Courier\ 12,fixed\ 12,\ 7x13
                :set guifont=Monospace\ 13
        elseif has("x11")
                "also for GTK 1
                :set guifont=-Courier_10_Pitch-Medium-R-Normal--14-110-70-70-C-75-ISO8859-1
        elseif has("gui_win32")
                :set guifont=Luxi_mono:h12:cANSI
        endif
endif

"""""""""""""""""""""""< menu and item >"""""""""""""""""""""
set guioptions+=m
set guioptions-=T
set guioptions+=b

"""""""""""""""""""""status columbar""""""""""""""""""""""""
set laststatus =2
"highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLine guifg=SlateBlue guibg=Gray

"""""""""""""""""""""<search setting>"""""""""""""""""""""""
"Override the 'ignorecase' option if the search pattern contains upper
"case characters.  Only used when the search pattern is typed and
"'ignorecase' option is on. 
set incsearch
set hls
"set ignorecase
set ignorecase smartcase
"set infercase
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""set match pairs"""""""""""""""""""""""
set showmatch
"How many tenths of a second to blink
set matchtime=5

"set guicursor=n:block-blinkoff0
"""""""""""""<set for chinese support>""""""""""""""""""""""""""
":language ja_JP.eucJP
":let &termencoding = &encoding
":set termencoding=euc-jp
set fileencodings=utf-8,gbk,big5,euc-jp,gb2312

"""""""""fold set""""""""""""""""
set foldmethod=marker
set foldcolumn=2
highlight Folded guibg=grey guifg=blue
highlight FoldColumn guibg=black guifg=white
""au BufWinLeave * silent mkview
""au BufWinEnter * silent loadview

""set nofoldenable
"""""""""""""""""""""""""<set tab space>""""""""""""""""""""""""
""tab=space setting for different editors
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

autocmd Filetype make  set noexpandtab 
""autocmd Filetype c,cpp set shiftwidth=2 tabstop=2 expandtab
autocmd Filetype verilog setlocal tabstop=3 softtabstop=3 shiftwidth=3 expandtab 
autocmd Filetype systemverilog setlocal tabstop=3 softtabstop=3 shiftwidth=3 expandtab 
"autocmd Filetype python setlocal tabstop=3 softtabstop=3 shiftwidth=3 expandtab 
autocmd FileType c,cpp :set cindent
set smartindent 
set autoindent 
"set cindent shiftwidth=4
"
"""""""""""""""""""""""<command_line mapping>""""""""""""""""""""""""""
cnoremap sv     :source ~/.vim/syntax/systemverilog.vim
""for python.vim switch use
let OPTION_NAME =1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.rdl set filetype=systemrdl 
""""""""""""""""""""""<some useful setting>""""""""""""""""""""

"open file type detecting
filetype on
filetype plugin on

"open syntax highlight
syntax enable
syntax on

"indent based on filetype
filetype indent on

"set cursorline
"vim self_cmd complete smartly
set wildmenu
set showcmd

""add "" to a word
nnoremap add" viw<ESC>a"<ESC>hbi"<ESC>lel
"delete words in () use d( command
onoremap ( i(
"some shortcut key like windows
"map all selected
"nmap <c-a> ggVG
"exit vim
nmap <c-q>  :q <CR>
"save file
nmap <c-s>  :w <CR>
"refresh file
nmap <c-e>  :Explore <CR>

"add doxygen c++ style comment
nmap <c-t>  :Dox <CR> 

vnoremap <Leader>y "+y
nmap <Leader>p "+p

nmap <silent> <c-h> <C-W><
nmap <silent> <c-j> <C-W>-
nmap <silent> <c-k> <C-W>+
nmap <silent> <c-l> <C-W>>

""nmap <silent> <c-n> <C-w><C-w>
""nmap <silent> <c-p> <C-w><S-w>

""minibuf switch between different buffer 
nmap <silent> <c-n> :bn <CR> 
nmap <silent> <c-p> :bp <CR>

""sos cmd in vim
""let $file_name = expand("%")
""nmap <Leader>co :!sosco $file_name 
""nmap <Leader>ci :!sosci $file_name 
""nmap <Leader>up :!sosup $file_name 
""nmap <Leader>di :!sosdis $file_name 

"""""""""""""""""""""auto_complete""""""""""""""""""""""""""""
""inoremap ( ()i
""inoremap ) =ClosePair(')')
""inoremap < <>i
""inoremap > =ClosePair('>')
""inoremap { {}i
""inoremap } =ClosePair('}')
""inoremap [ []i
""inoremap ] =ClosePair(']')
""inoremap " ""
":inoremap ' ''
function ClosePair(char)
if getline('.')[col('.')-1]==a:char
return "\<Right>"
else
return a:char
endif
endf

"""""""""""""""""""""<some setting don't why>"""""""""""""""""""
if &term=="xterm"
    set t_Co=8
    set t_Sb=^[[4%dm
    set t_Sf=^[[3%dm
endif

set undolevels=500
""set tw=120
set nu
set ru
set nocompatible
set nobackup
set noswapfile
set cmdheight=1
hi LineNr guibg=Gray30

""set formatoptions=tcrqnmM
set iskeyword+=_,$,@,%,#,-

set mousemodel=popup
set mouse=a

set bufhidden=hide
set backspace=2
"set whichwrap+=<,>,h,l
"Set to auto read when a file is changed from the outside
set autoread
set fileformats=unix,dos
"""""""""""""""""""<some setting don't why end>""""""""""""""""""
""color cursor and blink control
"hi Cursor      guibg=purple guifg=slategrey
hi Cursor guibg=blue guifg=slategrey
"set cursorline
set cursorcolumn

""comment color setting
hi comment guifg=gray50
""""""""""execute command in args deal with all files in buffer""""""""""
function Allargs(command)
 let i = 0
 while i < argc()
 if filereadable(argv(i))
 execute "e " . argv(i)
 execute a:command
 endif
 let i = i + 1
 endwhile
endfunction
command -nargs=* ALL :call Allargs(<q-args>)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F5> :call DefineDet()<cr>'s
function AddDefine()
    let s:classname = expand("%:r") 
    let s:extension = expand("%:e") 
    if s:extension =~ 'cpp' || s:extension =~ 'h' ||  s:extension =~ 'c'
        call append(0,"#ifndef " . "__" . toupper(s:classname . "_" . s:extension) ."__")
        call append(1,"#define " . "__" . toupper(s:classname . "_" . s:extension) ."__")
        call append(2,"")
        call append(3,"")
        let s:botline = line("$")
        call append(s:botline,"")
        let s:botline1 = s:botline+1
        call append(s:botline1,"#endif")
        let s:botline2 = s:botline+2        
    else 
        call append(0,"`ifndef " . "__" . toupper(s:classname . "_" . s:extension) ."__")
        call append(1,"`define " . "__" . toupper(s:classname . "_" . s:extension) ."__")
        call append(2,"")
        call append(3,"class " .expand("%:r") . " extends ;")
        call append(4,"   `uvm_component_utils(" . s:classname . ")")
        call append(5,"")
        call append(6,"")
        call append(7,"   function new(string name = \"" . s:classname . "\", uvm_component parent);")
        call append(8,"      super.new(name, parent);")
        call append(9,"   endfunction")
        call append(10,"")
        call append(11,"endclass")
        call append(12,"")
        call append(13,"`endif")
    endif
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf

function DefineDet()
    let n=0
    while n < 8 
        let line = getline(n)
        if line =~ '^`ifndef.*$'
            return
        endif
        let n = n + 1" Verilog HDL
au BufNewFile,BufRead *.v  setf verilog
    endwhile
    call AddDefine()
endfunction

map <F6> :call TitleDet()<cr>'s
function AddTitle()
    let s:extension = expand("%:e") 
    if s:extension =~ 'cpp' || s:extension =~ 'h' ||  s:extension =~ 'c'
        call append(0,"// ***********************************************************************")
        call append(1,"//                        Copyright Picocom, 2021")
        call append(2,"// ***********************************************************************")
        call append(3,"// PROJECT        : ".$project_name)
        call append(4,"// FILENAME       : ".expand("%:t"))
        call append(5,"// Author         : ".toupper($USER))
        call append(6,"// LAST MODIFIED  : ".strftime("%Y-%m-%d %H:%M"))
        call append(7,"// ***********************************************************************")
        call append(8,"// DESCRIPTION    :")    
        call append(9,"// ***********************************************************************")    
        call append(10,"// $Revision: $")
        call append(11,"// $Id: $")
        call append(12,"// ***********************************************************************")    
        ""let s:botline = line("$")
        ""call append(s:botline,"// ***********************************************************************")
        ""let s:botline1 = s:botline+1
        ""call append(s:botline1,"// $Log: $")
        ""let s:botline2 = s:botline+2
    else
        call append(0,"// ***********************************************************************")
        call append(1,"//                        Copyright Picocom, 2021")
        call append(2,"// ***********************************************************************")
        call append(3,"// PROJECT        : ".$project_name)
        call append(4,"// FILENAME       : ".expand("%:t"))
        call append(5,"// Author         : ".toupper($USER))
        call append(6,"// LAST MODIFIED  : ".strftime("%Y-%m-%d %H:%M"))
        call append(7,"// ***********************************************************************")
        call append(8,"// DESCRIPTION    :")    
        call append(9,"// ***********************************************************************")    
        call append(10,"// $Revision: $")
        call append(11,"// $Id: $")
        call append(12,"// ***********************************************************************")  

        ""call append(0,"// ***********************************************************************")
        ""call append(1,"// *****************                                                       ")
        ""call append(2,"// ***** ***********                                                       ")
        ""call append(3,"// *****   *********       Copyright (c) ".strftime("%Y"). " Analog Devices")
        ""call append(4,"// *****     *******               (BJ EMP group)                          ")
        ""call append(5,"// *****       *****         Analog Devices Confidential                   ")
        ""call append(6,"// *****     *******             All rights reserved                       ")
        ""call append(7,"// *****   *********                                                       ")
        ""call append(8,"// ***** ***********                                                       ")
        ""call append(9,"// *****************                                                       ")
        ""call append(10,"// ***********************************************************************")
        ""call append(11,"// PROJECT        : ".$project_name)
        ""call append(12,"// FILENAME       : ".expand("%:t"))
        ""call append(13,"// Author         : ".toupper($USER)." [". g:uvm_email ."]")
        ""call append(14,"// LAST MODIFIED  : ".strftime("%Y-%m-%d %H:%M"))
        ""call append(15,"// ***********************************************************************")
        ""call append(16,"// DESCRIPTION    :")    
        ""call append(17,"// ***********************************************************************")    
        ""call append(18,"// $Revision: $")
        ""call append(19,"// $Id: $")
        ""call append(20,"// ***********************************************************************")    
        ""let s:botline = line("$")
        ""call append(s:botline,"// ***********************************************************************")
        ""let s:botline1 = s:botline+1
        ""call append(s:botline1,"// $Log: $")
        ""let s:botline2 = s:botline+2
        ""call append(s:botline2,"// $Revision $")
    endif
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf

function UpdateTitle()
    normal m'
    execute '/# *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/# *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction

function TitleDet()
    let n=1
    while n < 10
        let line = getline(n)
        if line =~ '^\#\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction

""setting for minibuf tagbar color 
hi MBENormal guifg=grey77 
