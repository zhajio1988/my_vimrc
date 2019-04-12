" Vim syntax file "
" Language:	Log syntax file used to highlight errors/warnings "
" Maintainer:	David C Black <dcblack@hldwizard.com> "
" Last Change:	2001 Sep 3 "

" Remove any old syntax stuff hanging around "
syn clear

set iskeyword=@,48-57,_,192-255
set isfname=@,48-57,/,.,-,_,\+,$,~

syn case ignore

syn match  logDarkGreen   "\(BEGIN\|END\|TLM\)_\(REQ\|RESP\|COMPLETED\|ACCEPTED\)" contained
syn match  filelocation   "\<\w\+\.\(cpp\|h\):\d\+" contained
syn match  logDarkGreen   ".\+ [#]\{3,} .\+"
syn match  logDarkMagenta " >>> .\+"
syn match  logDarkMagenta " AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
syn match  logDarkMagenta " VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV"
syn match  logDarkRed     ".\+ [*]\{3,} .\+"
syn match  logError       ".\+ [!]\{3,} .\+"
syn match  logData        "^\(# *\)\?NOTE\>.*"
syn match  logData        "^\(# *\)\?DATA\>.*"
syn match  logData        "^\(# *\)\?IN\>.*"
syn match  logData        "^\(# *\)\?OUT\>.*"
syn match  logData        "^\s*|.*"
syn match  logDebug     "^\(# *\)\?\(- \)\?DEBUG.\+"
syn match  logDebug       "^\(# *\)\?dbg_msg_L.\+"
syn match  logDebug       "^.\+s: Debug: .\+"
syn match  logDebug       "^.\+s: DEBUG: .\+"
syn match  logEmail       contained "<.\{-}>"
syn match  logEmail       contained "[_=a-z\.\+A-Z0-9-]\+@[a-zA-Z0-9\./\-]\+"
syn match  logError       "^.\+ Error: .\+" contains=filelocation
syn match  logError       "^    E: .\+" contains=filelocation
syn match  logError       "^Ova \[\d\+\]: .\+"
syn match  logDarkGreen   "^.\+\(Warning\|Error\|Fatal\)(expected): .*"
syn match  logError       "^\s*!!!.\+"
syn match  logError       "^.\+: Undefined symbols: .*"
syn match  logError       "^.\+: undefined reference to .*"
syn match  logError       ".* not found.*"
syn match  logError       ".*: syntax error.*" contains=filelocation
syn match  logError       "^.*\<In file: .*"
syn match  logError       "^\(# *\)\?ASSERTION FAILED.*"
syn match  logError       "^\(# *\)\?ERROR.*"
syn match  logError       " [*]+ERROR[*]+"
syn match  logError       "^\(TEST\)\?ERROR VCP.\+"
syn match  logError       "^\(# *\)\?Error.\+"
syn match  logError       "^\(# *\)\?SEVERE.\+"
syn match  logError       "^\(# *\)\?Severe.\+"
syn match  logInfo        "^\s*\.\.\.preceding repeated \d\+ more time.\?"
syn match  logInfo        "\<pass\>"
syn match  logError       "\<failed\>"
syn match  logError       "^\(# *\)\?\(Simulation\|Test\) FAILED.\+"
syn match  logGood        "^\(# *\)\?\(Simulation\|Test\) PASSED.\+"
syn match  logError       "^\(# *\)\?\s*[1-9]\d* error.\+" contains=filelocation
syn match  logError       "^\(# *\)\?\s*[1-9]\d* fatal.\+"
syn match  logError       "^\d\+ \w\?s: Error:.\+" contains=filelocation
syn match  logError       ".\+/ld: cannot find -l.\+"
syn match  logError       ".\+ returned [1-9]\d* exit status\>"
syn match  logError       "^\w\+\.\(cpp\|h\):\d\+: .\+"
syn match  logError       "^ld: multiple .\+"
syn match  logError       "%Error: .\+"
syn match  logError       "^\(TEST\)\?FAILURE \".\+"
syn match  logError       "^ld: duplicate symbol .*"
syn match  logError       "^\w\+: ld returned 1 exit status"
syn match  logFatal       "^\(# *\)\?ABORT.\+"
syn match  logFatal       "^\(# *\)\?Abort.\+"
syn match  logFatal       "^\(# *\)\?FATAL.\+"
syn match  logFatal       "^\(# *\)\?Fatal.\+"
syn match  logFatal       ".*\<SIGSEGV, Segmentation fault.\+"
syn match  logFatal       "^.\+ Fatal: .\+"
syn match  logFatal       "%Fatal: .\+"
syn match  logInfo        "^.\+s: Info: .\+"
syn match  logInfo        "^Making .\+"
syn match  logInfo        "^\(# *\)\?sys_msg_INFO.\+"
syn match  logInfo        "^\(# *\)\?INFO.\+"
syn match  logInfo        "^\(# *\)\?Info.\+"
syn match  logData        "^.*\<\(ENTER\|LEAVE\|NOTE\|DATA\)\>.*"
syn match  logDebug       "^\(# *\)\?\(- \)\?DEBUG.\+"
syn match  logInfo        "^\(# *\)\?NOTE\>.\+"
syn match  logInfo        "^\(# *\)\?Note\>.\+"
syn match  logDarkMagenta "^\(# *\)\?Cmnd\>.\+"
syn match  logDarkMagenta "^\(# *\)\?CMND\>.\+"
syn match  logDarkGreen   "^\(# *\)\?Evnt\>.\+"
syn match  logDarkGreen   "^\(# *\)\?EVNT\>.\+"
syn match  logInfo        "^\(# *\)\?SUMMARY:.\+"
syn match  logInfo        "^\(# *\)\?\s*[1-9]\d* info.\+"
syn match  logInfo        "^\d\+ \w\?s: Info:.\+"
syn match  logInfo        "^make\[\d\+\]: .\+"
syn match  logInfo        "%Info: .\+"
syn match  logQuoted1     "^\s*#.\+" contains=filelocation
syn match  logQuoted2     "^%.\+"
syn match  logQuoted2     "^(gdb).\+"
syn match  logSep         ".*[#]\{10,}.*"
syn match  logSep         ".*[*]\{10,}.*"
syn match  logSep         ".*[-]\{10,}.*"
syn match  logSep         ".*[~]\{10,}.*"
syn match  logError       "^\(TEST\)\?WARNING VCP.\+"
syn match  logWarning     "^.\+s: \(ALERT\|Warning\): .\+"
syn match  logWarning     "^    W: .\+"
syn match  logWarning     "^[^: ]\+:\d\+: warning: .\+"
syn match  logWarning     "^\(# *\)\?\(ALERT\|WARN\).\+"
syn match  logWarning     "^\(# *\)\?Warning.\+"
syn match  logWarning     "^\(# *\)\?\s*[1-9]\d* warn.\+"
syn match  logWarning     "^\d\+ \w\?s: Warning:.\+"
syn match  logWarning     "^ld: warning .\+"
syn match  logWarning     "%Warning: .\+"
syn match  logRed         "^..01;31m.\+"

syn region logString  start=+"+  end=+"+  keepend

if !exists("did_log_syntax_inits")
  let did_log_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later "
  hi        logDarkMagenta ctermfg=DarkMagenta ctermbg=NONE guifg=DarkMagenta guibg=NONE gui=bold
  hi        logDarkCyan    ctermfg=DarkCyan    ctermbg=NONE guifg=DarkCyan    guibg=NONE gui=bold
  hi        logDarkRed     ctermfg=DarkRed     ctermbg=NONE guifg=DarkRed     guibg=NONE gui=bold
  hi        logDarkRedUL   ctermfg=DarkRed     ctermbg=NONE guifg=DarkRed     guibg=NONE gui=bold,underline
  hi        logDarkGreen   ctermfg=DarkGreen   ctermbg=NONE guifg=DarkGreen   guibg=NONE gui=bold
  hi        logDarkBlue    ctermfg=DarkBlue    ctermbg=NONE guifg=DarkBlue    guibg=NONE gui=bold
  hi        logRed         ctermfg=Red         ctermbg=NONE guifg=Red         guibg=NONE gui=bold
  hi        logRedUL       ctermfg=Red         ctermbg=NONE guifg=Red         guibg=NONE gui=bold,underline
  hi        logGreen       ctermfg=Green       ctermbg=NONE guifg=Green       guibg=NONE gui=bold
  hi        logBlue        ctermfg=Blue        ctermbg=NONE guifg=Blue        guibg=NONE gui=bold
  hi        logCyan        ctermfg=Cyan        ctermbg=NONE guifg=Cyan        guibg=NONE gui=bold
  hi  link  logSuccess     logBlue
  hi  link  logError       logRed
  hi  link  logWarning     logDarkMagenta
  hi  link  filelocation   logDarkBlue
  hi  link  logSep         logGreen
  hi  link  logSep         Separator  
  hi  link  logGood        logDarkGreen
  hi  link  logInfo        logSuccess 
  hi  link  logData        Statement 
  hi  link  logFatal       logError
  hi  link  logDebug       logRedUL
  hi  link  logQuoted1     Comment 
  hi  link  logQuoted2     Type    
  hi  link  logEmail       Special 
  hi  link  logString      String  
endif
let b:current_syntax = "log"
"END
