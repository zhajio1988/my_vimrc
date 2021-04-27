" Vim Plugin for UVM Code Automactic Generation
" Language:     Vim
" Maintainer:   Hong Jin <hon9jin@gmail.com>
" Version:      0.10
" Modifier:     jzhang8 2017-02-17 16:10 
" For version 7.x or above

if (exists("g:uvm_plugin_loaded") && g:uvm_plugin_loaded)
   finish
endif
let g:uvm_plugin_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

" set Author in the header
if exists("g:uvm_author")
    let s:uvm_author     = g:uvm_author
else
    let s:uvm_author     = $USER
endif

" set email address in the header
if exists("g:uvm_email")
    let s:uvm_email      = g:uvm_email
else
    let s:uvm_email      = s:uvm_author . "@analog.com"
endif

" List of all types
let s:type_list = ["driver","monitor","agent","sequence","sequencer","vir_seqr","config","interface"]

" normalize the path
" replace the windows path sep \ with /
function <SID>NormalizePath(path)
    return substitute(a:path, "\\", "/", "g")
endfunction

" Returns a string containing the path of the parent directory of the given
" path. Works like dirname(3). It also simplifies the given path.
function <SID>DirName(path)
    let l:tmp = <SID>NormalizePath(a:path)
    return substitute(l:tmp, "[^/][^/]*/*$", "", "")
endfunction

" Default templates directory
let s:default_template_dir = <SID>DirName(<SID>DirName(expand("<sfile>"))) . "templates"

" Makes a single [variable] expansion, using [value] as replacement.
"
function <SID>TExpand(variable, value)
    silent execute "%s/{:" . a:variable . ":}/" .  a:value . "/g"
endfunction

" Puts the cursor either at the first line of the file or in the place of
" the template where the %HERE% string is found, removing %HERE% from the
" template.
"
function <SID>TPutCursor()
    0  " Go to first line before searching
    if search("{:HERE:}", "W")
        let l:column = col(".")
        let l:lineno = line(".")
        silent s/{:HERE:}//
        call cursor(l:lineno, l:column)
    endif
endfunction

" Load the template, and read it
function <SID>TLoadCmd(template)
    if filereadable(a:template)
        " let l:tFile = a:template
        if a:template != ""
            execute "r " . a:template
            " call <SID>TExpandVars()
            " call <SID>TPutCursor()
            setlocal nomodified
        endif
    else
        echo "ERROR! Can not find" . a:template
    endif

endfunction


"
"  Look for global variables (if any), to override the defaults.
"
function! UVM_CheckGlobal ( name )
  if exists('g:'.a:name)
    exe 'let s:'.a:name.'  = g:'.a:name
  endif
endfunction    " ----------  end of function C_CheckGlobal ----------

" make a header
function s:UVMAddHeader()
    call append(0,"// ***********************************************************************")
    call append(1,"//                 Copyright (c) 2019.                                    ")
    call append(2,"//             PICOCOMTECH®  ALL RIGHTS RESERVED                          ")
    call append(3,"// ***********************************************************************")
    call append(4,"// PROJECT        : ".$project_name)
    call append(5,"// FILENAME       : ".expand("%:t"))
    call append(6,"// Author         : ".toupper($USER))
    call append(7,"// LAST MODIFIED  : ".strftime("%Y-%m-%d %H:%M"))
    call append(8,"// ***********************************************************************")
    call append(9,"// DESCRIPTION    :")    
    call append(10,"// ***********************************************************************")    
    call append(11,"// $Revision: $")
    call append(12,"// $Id: $")
    call append(13,"// ***********************************************************************") 
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
    ""call append(13,"// Author         : ".toupper(s:uvm_author)." [". s:uvm_email ."]")
    ""call append(14,"// LAST MODIFIED  : ".strftime("%Y-%m-%d %H:%M"))
    ""call append(15,"// ***********************************************************************")
    ""call append(16,"// DESCRIPTION    :")    
    ""call append(17,"// ***********************************************************************")    
    ""call append(18,"// $Revision: $")
    ""call append(19,"// $Id: $")
    ""call append(20,"// ***********************************************************************")  
endfunction

" make a header
function s:UVMAddTail()
    let s:botline = line("$")
    call append(s:botline,"// ***********************************************************************")
    let s:botline1 = s:botline+1
    call append(s:botline1,"// $Log: $")
    let s:botline2 = s:botline+2
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction

function! UVMEnv(name)
    let a:template_filename = "uvm_env.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TPutCursor()
    ""call s:UVMAddTail()
endfunction

function! UVMTest(name)
    let a:template_filename = "uvm_test.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    if (a:name == "base")
        let a:name_temp = "tc_base"
        let a:parent_name = "uvm_test"
    else
        let a:name_temp = "test"
        let a:parent_name = "tc_base"
    endif
    call <SID>TExpand("NAME", a:name_temp)
    call <SID>TExpand("PARENT", a:parent_name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TPutCursor()
    "call s:UVMAddTail()
endfunction

function! UVMAgent(name)
    let a:template_filename = "uvm_agent.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TExpand("TRANSACTION", g:transaction_name)
    call <SID>TPutCursor()
    "call s:UVMAddTail()
endfunction

function! UVMDriver(name)
    let a:template_filename = "uvm_driver.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TExpand("TRANSACTION", g:transaction_name)
    call <SID>TPutCursor()
    ""call s:UVMAddTail()
endfunction

function! UVMMon(name)
    let a:template_filename = "uvm_monitor.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TExpand("TRANSACTION", g:transaction_name)    
    call <SID>TPutCursor()
    ""call s:UVMAddTail()
endfunction

function! UVMSeq(name)
    let a:template_filename = "uvm_sequence.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TExpand("TRANSACTION", g:transaction_name)
    call <SID>TPutCursor()
    "call s:UVMAddTail()
endfunction

function! UVMVirSeqr(name)
    let a:template_filename = "uvm_vir_sequencer.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TPutCursor()
    ""call s:UVMAddTail()
endfunction

function! UVMSeqr(name)
    let a:template_filename = "uvm_sequencer.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TExpand("TRANSACTION", g:transaction_name)    
    call <SID>TPutCursor()
    ""call s:UVMAddTail()
endfunction

function! UVMTr(name)
    let a:template_filename = "uvm_transaction.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TPutCursor()
    ""call s:UVMAddTail()
endfunction

function! UVMTop(name)
    let a:template_filename = "uvm_test_top.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TPutCursor()
    ""call s:UVMAddTail()
endfunction

function! UVMConfig(name)
    let a:template_filename = "uvm_config.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)

    call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TPutCursor()
    "call s:UVMAddTail()
endfunction

function! UVMInterface(name)
    let a:template_filename = "uvm_interface.sv"
    let a:template = s:default_template_dir . "/" . a:template_filename
    let a:uppername = toupper(a:name)
    let a:lowername = tolower(a:name)

    " call s:UVMAddHeader()
    call <SID>TLoadCmd(a:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", a:uppername)
    call <SID>TExpand("LOWERNAME", a:lowername)
    call <SID>TPutCursor()
endfunction

" According to the args, call different methods
"
function UVMGen(type, name)
" function UVMGen(...)
"     let a:args_num = a:0
"     let a:type = a:1
"     let a:name = a:2
    if (a:type== "agent")
        call UVMAgent(a:name)
    elseif (a:type== "config")
        call UVMConfig(a:name)
    elseif (a:type== "interface")
        call UVMInterface(a:name)
    elseif (a:type== "driver") || (a:type == "drv")
        call UVMDriver(a:name)
    elseif (a:type== "monitor") || (a:type == "mon")
        call UVMMon(a:name)
    elseif (a:type== "sequence") || (a:type == "seq")
        call UVMSeq(a:name)
    elseif (a:type== "vir_seqr")
        call UVMVirSeqr(a:name)        
    elseif (a:type== "sequencer") || (a:type== "seqr")
        call UVMSeqr(a:name)        
    else
        echo "The first ARG, Please following the instructions:"
        echo " driver / drv     - Generate UVM Driver"
        echo " monitor / mon    - Generate UVM Monitor"
        echo " agent            - Generate UVM Agent"
        echo " sequence / seq   - Generate UVM Vir Base Sequence"
        echo " sequencer / seqr - Generate UVM Sequencer"        
        echo " vir_seqr         - Generate UVM Vir Sequencer"        
        echo " config           - Generate UVM Config"
        echo " interface        - Generate UVM Interface"        
        echo " env              - Generate UVM Env"
        echo " test             - Generate UVM Test"
        echo " top              - Generate UVM Top"
        echo " item / it        - Generate UVM Sequence Item"
    endif
endf

" Return types name as arguments
function ReturnTypesList(A,L,P)
    return s:type_list
endf

" === plugin commands === {{{
command -nargs=0 UVMAddHeader call s:UVMAddHeader()
command -nargs=1 UVMEnv call UVMEnv("<args>")
command -nargs=1 UVMTest call UVMTest("<args>")
command -nargs=1 UVMAgent call UVMAgent("<args>")
command -nargs=1 UVMDriver call UVMDriver("<args>")
command -nargs=1 UVMMon call UVMMon("<args>")
command -nargs=1 UVMSeq call UVMSeq("<args>")
command -nargs=1 UVMTr call UVMTr("<args>")
command -nargs=1 UVMItem call UVMTr("<args>")
command -nargs=1 UVMTop call UVMTop("<args>")
command -nargs=1 UVMConfig call UVMConfig("<args>")
command -nargs=1 UVMInterface call UVMInterface("<args>")
command -nargs=+ -complete=customlist,ReturnTypesList UVMGen call UVMGen(<f-args>)
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
