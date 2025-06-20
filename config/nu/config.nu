# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config.buffer_editor = "nvim"
$env.config = {
    table: {
        mode: rounded
    }
}
$env.GPG_TTY = ^tty
$env.config.edit_mode = 'vi'
$env.PROMPT_INDICATOR = "〉"
$env.PROMPT_INDICATOR = "〉"
$env.PROMPT_INDICATOR_VI_INSERT = " 〉"
$env.PROMPT_INDICATOR_VI_NORMAL = " ❮ "
$env.config.show_banner = false

# Right-side prompt with clock + Guix environment info
$env.PROMPT_COMMAND_RIGHT = {
    let time_str = (date now | format date "%H:%M:%S")

    let guix_info = if ($env | columns | any {|col| $col == "GUIX_ENVIRONMENT" }) {
        " [GUIX ENV]"
    } else {
        ""
    }

    $"($time_str)($guix_info)"
}

