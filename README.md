
# Guix Home Configuration

This repository contains my Guix System/Home configuration files, enabling a reproducible and customizable `i3` environment. Below is an overview of the packages, services, and configurations used in this setup.

## Packages

The following packages are included in the home profile for a versatile environment:

- **Tools & Utilities**: `feh`, `lf`, `git`, `curl`, `ncdu`, `file`, `xclip`, `zathura`, `zathura-pdf-mupdf`, `ranger`, `openssh`, `mpv`, `ncmpcpp`, `rg`, `fzf`
- **Development Tools**: `neovim`, `gnupg`, `direnv`, `rbw`, `aerc`
- **Fonts**: `font-iosevka-term`, `font-atkinson-hyperlegible`, `font-google-noto`, `font-google-noto-sans-cjk`
- **Browsers**: `ungoogled-chromium`, `firefox`
- **Media**: `mpd`, `gimp`, `easyeffects`, `pulsemixer`
- **Other**: `bibata-cursor-theme`, `picom`, `xcalib`

## Home Services

### Shell Configuration
- **Fish**: Fish shell configuration is included, with the main config file sourced from the `config/fish/config.fish`.

### Desktop and Media
- **PipeWire**: Configured for audio services with PulseAudio compatibility.
- **Picom**: Configuration is included for the compositor.
- **MPD**: Managed through the Shepherd init system, ensuring the Music Player Daemon starts and stops properly.
- **XDG Directories**: Sets up common directories like `$HOME/Documents`, `$HOME/Music`, and `$HOME/Downloads`.
- 

### Environment Variables
- **EDITOR**: Set to `nvim` to use Neovim as the default editor.

### GPG and SSH
- **GPG Agent**: Configured with `pinentry-tty` for GPG key management. SSH support is disabled.
- **SSH Agent**: Includes additional options for session duration (`-t 1h30m`).

### Miscellaneous
- **DBus**: Included as a dependency for several desktop services.
- **User Files**: Configuration files like `.xinitrc`, i3 window manager, Alacritty, MPD, NCMPCPP, Polybar, and fontconfig are loaded from the local `config/` directory.

## Installation

To apply this configuration on your system, use the following commands and replace x with the system:

```bash
sh ./install.sh
guix -L pathToRepo system reconfigure pathToRepo/systems/x.scm
guix home reconfigure home-environment.scm
```

Make sure to capture your current Guix channels using `guix describe` to ensure the configuration is fully reproducible or use the provided `channels-lock.scm` file.

### Replication

For full reproducibility of this setup, ensure you also replicate the exact Guix channels and commit using:

```bash
guix describe
```

## Contribution

Feel free to open issues or submit pull requests for improvements or new features.

