
# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions
#########################################################
# 2020.5.10 
########################################################
# picocom ic group
########################################################

source /opt/picocom/tools/toolconfigs/toolconfig.sh

if [ -f ~/own.bashrc ]; then
	source ~/own.bashrc	#Define your own bash settings file and named the file own.bashrc
fi

module use /cad/modulefiles

#=============basic==============

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias sou='source ~/.bashrc'

alias his='history'
alias grep='grep -n --color=auto'
alias du1="du -h --max-depth=1"
alias du2="du -h --max-depth=2"

alias vi='gvim'
alias v='gvim'
alias g='gvim'
alias l='ll -h'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias .....='cd ../../../../'

#=============function===========

function dun() {
	du -h --max-depth=$1;
}

#=============paths==============

alias user='cd /ic/user/`whoami`/'
alias app='cd /ic/app/'
alias work='cd /ic/proj/`whoami`'
alias temp='cd /ic/temp/`whoami`'
alias libs='cd /huaihe/proj/ic/libs'

#=============sos================

export CLIOSOFT_DIR=/cad/clio/sos_7.04.p1_linux64
export PATH=/cad/clio/sos_7.04.p1_linux64/bin:$PATH
export CLIOLMD_LICENSE_FILE=5281@172.16.18.31

#=============lsf================

source /cad/lsf/conf/profile.lsf
