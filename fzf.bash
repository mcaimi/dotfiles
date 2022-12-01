# FZF settings for various tools
bind -m vi -x '"\C-f": "code_file=$( find $PWD -type f | rg -f ~/Work/dotfiles/codefile-patterns | fzf-tmux -h ); [ $? -eq 0  ] && vim $code_file"'

