# my_vimrc
jude's vimrc for DV work(fine tuning for SV/UVM)

## install 
`git config --global core.autocrlf false`

`git clone https://github.com/zhajio1988/my_vimrc.git`

`cp my_vimrc/* ~/`

## plugin
```
hl_matchit.vim  
verilog_systemverilog.vim
verilog-support  
vim-easymotion
winmanager.vim
tagbar.vim
supertab.vim
minibufexpl.vim
localrc.vim
fastfold.vim
verilog_emacsauto.vim
uvm_gen.vim
omni completion
pathogen.vim
```

## how to use

| command | description |
| ------ | ------ |
| Ctrl+s |	 保存 	|			
| Ctrl+q |	 退出gvim，一般先保存，再进行这个操作 | 				
| Ctrl+e |	 刷新 				|
| Ctrl+j 或 Ctrl+k 	| 打开多个编辑窗口时，上下调节窗口大小 		|		
| Ctrl+h 或 Ctrl+l |	 打开多个编辑窗口时，左右调节窗口大小 		|		
| Ctrl+n |	 打开多个文件时，在不同文件间切换，切换到下一个文件 |		
| Ctrl+p |	 打开多个文件时，在不同文件间切换，切换到上一个文件 |	
| F4 	| 启动tagbar 	|			
| F5 	| 添加文件头 	|			
| F6 |	 新建sv文件，自动生成部分代码 			|
| 在normal状态下输入\a 	| 缩进混乱的sv文件，自动缩进 			|	
| 在normal状态下输入"wm" | vim下管理窗口的插件，可以管理文件浏览器、缓冲区、taglist等窗口 |
| 在normal状态下输入\a 	| 缩进混乱的sv文件，自动缩进 			|	
| 在normal状态下输入\\\w \\\b | 跳转到当前光标前后的位置		|	
| 行级跳转(\\\j \\\k \\\h \\\l) |  hjkl 快速跳转 |

## reference
https://github.com/junegunn/fzf

https://segmentfault.com/a/1190000015977368

http://www.wklken.me/posts/2015/06/07/vim-plugin-easymotion.html

http://www.wklken.me/posts/2015/06/07/vim-plugin-tagbar.html
