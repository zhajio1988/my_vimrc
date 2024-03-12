"Author: Nachum Kanovsky
"Email: nkanovsky@yahoo.com
"Version: 1.15
augroup filetypedetect
    au! BufRead,BufNewFile *.sv,*.svi,*.svh,*.v,*.vh,*.vp,*.svp,*.sva setfiletype systemverilog
augroup END
