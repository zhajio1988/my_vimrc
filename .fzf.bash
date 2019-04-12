# Setup fzf
# ---------
if [[ ! "$PATH" == */home/zhajio/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/zhajio/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/zhajio/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/zhajio/.fzf/shell/key-bindings.bash"
