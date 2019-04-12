if exists('g:loaded_hl_matchit')
  finish
endif
let g:loaded_hl_matchit = 1

let s:save_cpo = &cpo
set cpo&vim

let s:SPEED_MOST_IMPORTANT = 1
let s:SPEED_DEFAULT = 2


if !exists('g:hl_matchit_hl_groupname')
  let g:hl_matchit_hl_groupname = 'cursorline'
endif
if !exists('g:hl_matchit_hl_priority')
  let g:hl_matchit_hl_priority = 0
endif
if !exists('g:hl_matchit_speed_level')
  let g:hl_matchit_speed_level = s:SPEED_DEFAULT
endif
if !exists('g:hl_matchit_cursor_wait')
  let g:hl_matchit_cursor_wait = 0.200
endif
if !exists('g:hl_matchit_allow_ft')
  let g:hl_matchit_allow_ft = ''
endif

if exists('g:hl_matchit_allow_ft_regexp')
  echoerr 'hl_matchit: g:hl_matchit_allow_ft_regexp is removed. use g:hl_matchit_allow_ft'
endif



com! HiMatch call hl_matchit#do_highlight()
com! NoHiMatch call hl_matchit#hide()
com! HiMatchOn call hl_matchit#enable()
com! HiMatchOff call hl_matchit#disable()

if exists('g:hl_matchit_enable_on_vim_startup') && g:hl_matchit_enable_on_vim_startup
    HiMatchOn
endif

let &cpo = s:save_cpo
unlet s:save_cpo

