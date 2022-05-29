"============================================================================
"  File:  systemrdl.vim
"
"  Description:
"
"  Vim syntax file for SystemRDL.
"
"  Author:   Manning Aalsma <maalsma@altera.com>
"  Date:     Thursday May 14, 2015 01:16:03 PM
"  Version:  1.0
"
"  Revision History:
"
"  1.0 -- Initial version.
"============================================================================

if version < 600
   syntax clear
elseif exists("b:current_syntax")
   finish
endif

syn sync lines=1000

syn keyword rdlStatement addrmap
syn keyword rdlStatement regfile
syn keyword rdlStatement reg
syn keyword rdlStatement field
syn keyword rdlStatement default

syn match   rdlProperty  "\(->\s*\)\@<!\<[a-zA-Z0-9_]\+\>\ze\s*="

syn keyword rdlTodo contained TODO FIXME

syn region  rdlComment start="/\*" end="\*/" contains=rdlTodo,@Spell
syn match   rdlComment "//.*" contains=rdlTodo,@Spell

syn region  rdlEmbeddedPerl start="<%" end="%>"
syn match   rdlVerilogPreProc "`include"
syn match   rdlVerilogPreProc "`[a-zA-Z0-9_]\+\>"

syn match   rdlOperator "[{}=->\[\]:;]"
syn region  rdlString   start=+"+ skip=+\\"+ end=+"+ contains=rdlEscape,rdlEmbeddedPerl,@Spell
syn match   rdlEscape   +\\[nt"\\]+ contains=rdlEscape,@Spell
syn match   rdlEscape   "\\\o\o\=\o\=" contains=rdlEscape,@Spell

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_rdl_syn_inits")
   if version < 508
      let did_rdl_syn_inits = 1
      command -nargs=+ HiLink hi link <args>
   else
      command -nargs=+ HiLink hi def link <args>
   endif

   " The default highlighting.
   HiLink rdlStatement      Statement
   HiLink rdlProperty       Identifier
   HiLink rdlString         String
   HiLink rdlComment        Comment
   HiLink rdlTodo           Todo
   HiLink rdlEmbeddedPerl   PreProc
   HiLink rdlVerilogPreProc PreProc
   HiLink rdlOperator       Special
   HiLink rdlEscape         Special

   delcommand HiLink
endif

let b:current_syntax = "systemrdl"

" vim: ts=4

