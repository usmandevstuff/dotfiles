## ░▀▀█░█▀▀░█░█░█▀▄░█▀▀
## ░▄▀░░▀▀█░█▀█░█▀▄░█░░
## ░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀
##
## rxyhn's Z-Shell configuration
## https://github.com/rxyhn
#usefull disk commands for cleaning
# df -h
# ncdu /
# dysk

# zmodload zsh/zprof

while read file
do
  source "$ZDOTDIR/$file.zsh"
done <<-EOF
ohmyzsh
env
aliases
utility
options
plugins
keybinds
EOF

eval "$(fnm env --use-on-cd --shell zsh)"
# export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml; eval "$(starship init zsh)"
# eval "$(zoxide init zsh)"
unalias zi

# zprof

# vim:ft=zsh:nowrap
