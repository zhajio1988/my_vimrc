#!/bin/csh -f

set filelist = `find ./`
foreach file ($filelist)
    if($file =~ "*.sv") then
        gvim -es -c ":Eamcsauto" -c ":w" -c ":q" $file
    endif
end
