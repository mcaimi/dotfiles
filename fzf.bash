# FZF settings for vsrious tools
export SKIM_DEFAULT_OPTIONS="--ansi --height=25 --layout=reverse --margin=TRBL --prompt='SKIM > ' --header='Indexing $PWD'"
bind -m vi -x '"\C-f": "code_file=$( find $PWD -type f | rg -f ~/Work/dotfiles/codefile-patterns | sk-tmux ); [ $? -eq 0  ] && vim $code_file"'

