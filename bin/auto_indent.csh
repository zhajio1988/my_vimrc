#!/bin/csh -f

set filelist = `find ./`
foreach file ($filelist)
    if($file =~ "*.sv") then
        echo $file
        gvim -es -c ":Emacsauto" -c ":wq" $file
    endif
end
