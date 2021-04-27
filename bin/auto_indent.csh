#!/bin/csh -f

set filelist = `find ./`
foreach file ($filelist)
    if($file =~ "*.sv" || $file =~ "*.svh") then
        vim -e -c ":Emacsauto" -c ":w" -c ":q" $file
    endif
end
