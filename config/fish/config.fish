# Direnv hook
export DIRENV_WARN_TIMEOUT=0

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

set -g tide_character_color purple

export GPG_TTY=$(tty)

direnv hook fish | source
