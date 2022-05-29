# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jiongz/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/jiongz/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/jiongz/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/jiongz/.fzf/shell/key-bindings.bash"
