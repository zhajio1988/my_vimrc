" Vim filetype plugin for using emacs verilog-mode
" Last Change: 2007 August 29
" Maintainer:  Seong Kang <seongk@wwcoms.com>
" License:     This file is placed in the public domain.

" comment out these two lines
" if you don't want folding or if you prefer other folding methods
setlocal foldmethod=expr
setlocal foldexpr=VerilogEmacsAutoFoldLevel(v:lnum)

if exists("loaded_verilog_emacsauto")
   finish
endif
let loaded_verilog_emacsauto = 1

" map \a, \d pair to Add and Delete functions, assuming \ is the leader
" alternatively, map C-A, C-D to Add and Delete functions
if !hasmapto('<Plug>VerilogEmacsAutoAdd')
   "map <unique> <Leader>a <Plug>VerilogEmacsAutoAdd
   map <unique> <C-A> <Plug>VerilogEmacsAutoAdd
endif
if !hasmapto('<Plug>VerilogEmacsAutoDelete')
   "map <unique> <Leader>d <Plug>VerilogEmacsAutoDelete
   "map <unique> <C-D> <Plug>VerilogEmacsAutoDelete
endif

noremap <unique> <script> <Plug>VerilogEmacsAutoAdd    <SID>Add
noremap <unique> <script> <Plug>VerilogEmacsAutoDelete <SID>Delete
noremap <SID>Add    :call <SID>Add()<CR>
noremap <SID>Delete :call <SID>Delete()<CR>
" add menu items for gvim
noremenu <script> Indent.Verilog\ AddAuto    <SID>Add
noremenu <script> Indent.Verilog\ DeleteAuto <SID>Delete

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
   w! %.emacsautotmp
   !emacs -batch --no-site-file -l ~/.emacs.d/verilog-mode.el %.emacsautotmp -f verilog-batch-indent
   %!cat %.emacsautotmp 
   if &expandtab
      retab
      let &tabstop=s:save_tabstop
   endif
   !rm %.emacsautotmp
endfunction

" Delete function
" saves current document to a temporary file
" runs the temporary file through emacs
" replaces current document with the emacs filtered temporary file
" removes temporary file
function s:Delete()
   " a tmp file is need 'cause emacs doesn't support the stdin to stdout flow
   " maybe add /tmp to the temporary filename
   w! %.emacsautotmp
   !emacs -batch --no-site-file -l ~/.emacs.d/verilog-mode.el %.emacsautotmp -f verilog-batch-delete-auto
   %!cat %.emacsautotmp 
   !rm %.emacsautotmp
endfunction

" VerilogEmacsAutoFoldLevel function
" only deals with 0 and 1 levels
function VerilogEmacsAutoFoldLevel(l)
   if (getline(a:l-1)=~'\/\*A\S*\*\/' && getline(a:l)=~'\/\/ \(Outputs\|Inputs\|Inouts\|Beginning\)')
      return 1
   endif
   if (getline(a:l-1)=~'\(End of automatics\|);\)')
      return 0
   endif
   return '='
endfunction
