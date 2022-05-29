" Vim filetype plugin for using emacs verilog-mode
" Last Change: 2018 August 28
" Origin Author:  Seong Kang <seongk@wwcoms.com>
" Author: Harris Zhu <zhuzhzh@163.com>
" License:     This file is placed in the public domain.

" comment out these two lines
" if you don't want folding or if you prefer other folding methods
"setlocal foldmethod=expr
"setlocal foldexpr=SVerilogEmacsAutoFoldLevel(v:lnum)

if exists("loaded_sverilog_emacsauto")
   finish
endif
let loaded_sverilog_emacsauto = 1

function! s:InitVar(var, value)
    if !exists(a:var)
        exec 'let '.a:var.'='.string(a:value)
    endif
endfunction
" map \a, \d pair to Add and Delete functions, assuming \ is the leader
" alternatively, map C-A, C-D to Add and Delete functions

let s_DefaultPath = expand("$HOME") . "/.emacs.d/verilog-mode.el"

call s:InitVar('g:SVerilogModeAddKey', '<leader>va')
call s:InitVar('g:SVerilogModeDeleteKey', '<leader>vd')
call s:InitVar('g:VerilogModeFile', s_DefaultPath)
call s:InitVar('g:VerilogModeTrace', 0)

"if !hasmapto('<Plug>SVerilogEmacsAutoAdd')
"map <unique> <leader>a <Plug>SVerilogEmacsAutoAdd
"endif
try
    if g:SVerilogModeAddKey != ""
        exec 'nnoremap <silent><unique> ' g:SVerilogModeAddKey '<Plug>SVerilogEmacsAutoAdd'
    endif
catch /^Vim\%((\a\+)\)\=:E227/
endtry

"if !hasmapto('<Plug>SVerilogEmacsAutoDelete')
"   map <unique> <leader>d <Plug>SVerilogEmacsAutoDelete
"endif
try
    if g:SVerilogModeDeleteKey != ""
        exec 'nnoremap <silent><unique> ' g:SVerilogModeDeleteKey '<Plug>SVerilogEmacsAutoDelete'
    endif
catch /^Vim\%((\a\+)\)\=:E227/
endtry



noremap <unique> <script> <Plug>SVerilogEmacsAutoAdd    <SID>Add
noremap <unique> <script> <Plug>SVerilogEmacsAutoDelete <SID>Delete
noremap <SID>Add    :call <SID>Add()<CR>
noremap <SID>Delete :call <SID>Delete()<CR>
" add menu items for gvim
noremenu <script> Verilog-Mode.AddAuto    <SID>Add
noremenu <script> Verilog-Mode.DeleteAuto <SID>Delete

let s:is_win = has('win16') || has('win32') || has('win64')

" Add function
" saves current document to a temporary file
" runs the temporary file through emacs
" replaces current document with the emacs filtered temporary file
" removes temporary file
" also replaces emacs generated tabs with spaces if expandtab is set
" comment out the two if blocks to leave the tabs alone
function s:Add()
   if &expandtab
      let s:save_tabstop = &tabstop
      let &tabstop=8
   endif
   " a tmp file is need 'cause emacs doesn't support the stdin to stdout flow
   " maybe add /tmp to the temporary filename
   let l:tmpfile = expand("%:p:h") . "/." . expand("%:p:t")
   "echom l:tmpfile
   silent! call writefile(getline(1, "$"), fnameescape(l:tmpfile), '')
   if g:VerilogModeTrace
	   exec "silent !emacs -batch --no-site-file -l ". g:VerilogModeFile . " " . shellescape(l:tmpfile, 1) . " -f verilog-batch-auto"
   else
	   exec "silent !emacs -batch --no-site-file -l ". g:VerilogModeFile . " " . shellescape(l:tmpfile, 1) . " -f verilog-batch-auto 2> /dev/null"
   endif
   let l:newcontent = readfile(fnameescape(l:tmpfile), '')
   
   if &expandtab
      retab
      let &tabstop=s:save_tabstop
   endif
   "call deletebufline('.', 1, '$')
   let l:i=1
   call setline(1, l:newcontent)
   exec "silent !rm " . shellescape(l:tmpfile)
   w! %
   exec 'redraw!'
endfunction

" Delete function
" saves current document to a temporary file
" runs the temporary file through emacs
" replaces current document with the emacs filtered temporary file
" removes temporary file
function s:Delete()
   " a tmp file is need 'cause emacs doesn't support the stdin to stdout flow
   " maybe add /tmp to the temporary filename
   let l:tmpfile = expand("%:p:h") . "/." . expand("%:p:t")
   "exec 'wrtie'   fnameescape(l:tmpfile)
   silent! call writefile(getline(1, "$"), fnameescape(l:tmpfile), '')
   if g:VerilogModeTrace
	   exec "silent !emacs -batch --no-site-file -l " . g:VerilogModeFile . " " . l:tmpfile . " -f verilog-batch-delete-auto"
   else
	   exec "silent !emacs -batch --no-site-file -l " . g:VerilogModeFile . " " . l:tmpfile . " -f verilog-batch-delete-auto 2> /dev/null"
   endif
   exec "silent %!cat " . shellescape(l:tmpfile)
   exec "silent !rm " . shellescape(l:tmpfile)
   w! %
   exec 'redraw!'
endfunction

" SVerilogEmacsAutoFoldLevel function
" only deals with 0 and 1 levels
function SVerilogEmacsAutoFoldLevel(l)
   if (getline(a:l-1)=~'\/\*A\S*\*\/' && getline(a:l)=~'\/\/ \(Outputs\|Inputs\|Inouts\|Beginning\)')
      return 1
   endif
   if (getline(a:l-1)=~'\(End of automatics\|);\)')
      return 0
   endif
   return '='
endfunction
