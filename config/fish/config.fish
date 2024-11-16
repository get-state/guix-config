# Direnv hook
export DIRENV_WARN_TIMEOUT=0

set -g tide_character_color purple

export GPG_TTY=$(tty)

direnv hook fish | source
