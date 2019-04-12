" ---------------------------------------------------------------------------
"
" Copyright(c): ClioSoft, Inc., 2011, All rights reserved.
"
" Description: Vim plugin for SOS.
"
" ---------------------------------------------------------------------------

" Exit when your app has already been loaded
if exists("loaded_sos")
   finish
endif
let loaded_sos=1

let s:save_cpo=&cpo
set cpo&vim


"Basic check for sos-enablement
if exists("$CLIOSOFT_DIR")
  let s:sosExecutable = $CLIOSOFT_DIR . "/bin/soscmd"
else
  let s:sosExecutable = "soscmd"
endif
if ! executable(s:sosExecutable)
  finish
endif 

" Keyboard shortcuts - default <Leader> is \
map <silent> <Leader>cr :call <SID>sosCreate()<CR>
map <silent> <Leader>co :call <SID>sosCheckOut()<CR>
map <silent> <Leader>ci :call <SID>sosCheckIn()<CR>
map <silent> <Leader>di :call <SID>sosDiscardCO()<CR>
map <silent> <Leader>up :call <SID>sosUpdateFile()<CR>
map <silent> <Leader>s :call <SID>sosInvoke()<CR>
map <silent> <Leader>h :echo <SID>sosHelp()<CR>

" menus
menu <silent> &SOS.Create :call <SID>sosCreate()<CR>
menu <silent> &SOS.Checkout :call <SID>sosCheckOut()<CR>
menu <silent> &SOS.Checkin :call <SID>sosCheckIn()<CR>
menu <silent> &SOS.Discard\ Checkout :call <SID>sosDiscardCO()<CR>
menu <silent> &SOS.Update\ File :call <SID>sosUpdateFile()<CR>
menu <silent> SOS.-Sep1- :
menu <silent> &SOS.Open\ SOS :echo <SID>sosInvoke()<CR>
menu <silent> &SOS.Help :echo <SID>sosHelp()<CR>

"----------------------------------------------------------------------------
" A wrapper around sos command line for the current buffer
"----------------------------------------------------------------------------
function s:sosCommandCurrentBuffer( sCmd )
  let sReturn = ""
  let filename = expand( "%:p" )
  let sCommandLine = s:sosExecutable . " " . a:sCmd . " " . filename
  let v:errmsg = ""
  let sReturn = system( sCommandLine )
  if v:errmsg == ""
    if v:shell_error != 0
      let v:errmsg = sReturn
    else
      echo sReturn
    endif
  else
    echo sReturn
  endif
endfunction

"----------------------------------------------------------------------------
" Create
"----------------------------------------------------------------------------
function s:sosCreate()
  let desc = ""
  let desc = inputdialog( "Description: ")
  echo "\n"
  call s:sosCommandCurrentBuffer("create -aDesc=\"" . desc . "\" ")
  if v:errmsg != ""
    echoerr "Unable to create file : " . v:errmsg
    return
  else
    e!
    call s:sosRestoreLastPosition()
  endif
endfunction

"----------------------------------------------------------------------------
" Check out
"----------------------------------------------------------------------------
function s:sosCheckOut()
  call s:sosCommandCurrentBuffer("co")
  if v:errmsg != ""
    echoerr "Unable to open file for edit : " . v:errmsg
    return
  else
    e!
    call s:sosRestoreLastPosition()   
  endif
endfunction

"----------------------------------------------------------------------------
" Check in
"----------------------------------------------------------------------------
function s:sosCheckIn()
  let desc = ""
  let desc = inputdialog( "Description: ")
  echo "\n"
  call s:sosCommandCurrentBuffer("ci -aLog=\"" . desc . "\" ")
  if v:errmsg != ""
    echoerr "Unable to checkin file : " . v:errmsg
    return
  else
    e!
    call s:sosRestoreLastPosition()
  endif
endfunction

"----------------------------------------------------------------------------
" Discard checkout
"----------------------------------------------------------------------------
function s:sosDiscardCO()
  let action=confirm("Discard checkout?\nChanges to your file will be lost." ,"&Yes\n&No", 2, "Question")
  if action == 1
    call s:sosCommandCurrentBuffer( "discardco -F" )
    if v:errmsg != ""
      echoerr "Unable to discard checkout of file : " . v:errmsg
      return
    else
      e!
      call s:sosRestoreLastPosition()
    endif
  endif
endfunction

"----------------------------------------------------------------------------
" Update a file
"----------------------------------------------------------------------------
function s:sosUpdateFile()
  call s:sosCommandCurrentBuffer( "userev -rso" )
  if v:errmsg != ""
    echoerr "Unable to update file : " . v:errmsg
    return
  else
    e!
  endif
endfunction

"----------------------------------------------------------------------------
" Invoke sos gui
"----------------------------------------------------------------------------
function s:sosInvoke()
  call s:sosCommandCurrentBuffer("gui")
  if v:errmsg != ""
    echoerr "Unable to open sos : " . v:errmsg
    return
  else
    call s:sosRestoreLastPosition()   
  endif
endfunction

"----------------------------------------------------------------------------
" Restore last position when re-opening a file 
" after co, ci, disc, update
"----------------------------------------------------------------------------
function s:sosRestoreLastPosition()
  if line("'\"") > 0 && line("'\"") <= line("$") |
    exe "normal g`\"" |
  endif
endfunction


"----------------------------------------------------------------------------
" Display help
"----------------------------------------------------------------------------
function s:sosHelp()
    return "Format: <Leader>letter, where letter is one of:\n" .
    \ "h - Display this help message\n" .
    \ "cr - Create a file in SOS\n" .
    \ "co - Check out a file\n" .
    \ "ci - Check in a file\n" .
    \ "di - Discard check out of file\n" .
    \ "up - Update file\n" .
    \ "s - Invoke sos gui\n" .
    \ "\n" .
    \ "Default <Leader> is \\" .
    \ ""
endfunction
