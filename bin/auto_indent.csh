#!/bin/csh -f

set filelist = `find ./`
foreach file ($filelist)
    if($file =~ "*.sv") then
        echo $file
        gvim -e -c ":Emacsauto" -c ":wq" $file
    endif
end
