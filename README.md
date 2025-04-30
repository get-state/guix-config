```markdown
# Guix Config Repository

This repository contains my personal configuration files for Guix System and Guix Home. The setup focuses on a reproducible, customizable environment, particularly optimized for the `i3` window manager and Neovim for development.

---

## Repository Overview

### Key Features
- **Custom Guix System Configurations**: Tailored to match specific requirements for both Guix System and Home.
- **Neovim Configuration**: Extensive plugin setup using `lazy.nvim`, supporting modern editing features like LSP (Language Server Protocol), syntax highlighting, and auto-completion.
- **Desktop Environment**:
  - `i3` window manager setup.
  - `Picom` for compositor.
  - `Polybar`, `Alacritty`, and other GUI configurations.
- **Audio & Media Management**:
  - Configured with `PipeWire` and `MPD`.
- **Shell Customization**:
  - Based on `Fish/nu` shell with specific extensions and environment variables.

---

## Configuration Highlights

### Shell Configuration
- **Fish Shell**: Includes configuration sourced from `config/fish/config.fish`. Environment variables, aliases, and customizations are set here.
- **Environment Variables**:
  - **Default Editor**: `nvim` (Neovim).
  - **GPG Agent**: Configured for `pinentry-tty`.
  - **SSH Agent**: Customized session duration.

### Desktop Environment
- **i3 Window Manager**: Configured for simplicity and efficiency.
- **Polybar and Picom**: Enhancing the appearance and functionalities of the desktop environment.
- **XDG Directories**: Automatically sets up user directories like `$HOME/Documents` and `$HOME/Music`.

### Neovim Configuration
Located under `config/nvim/lua/config.lua`. Key highlights:
- **Plugin Manager**: Uses `lazy.nvim` for efficient plugin loading.
- **Customization**: Includes themes like `kanagawa` and `catppuccin`, along with configurations for LSP, Treesitter, and more.
- **Development Tools**: Provides support for languages like Lua, Python, and Rust using LSP servers.

### Package List
- **Development Tools**: `neovim`, `direnv`, `gnupg`.
- **Utilities**: `lf`, `ncdu`, `mpv`.
- **Media**: `mpd`, `ncmpcpp`.
- **Fonts**: `font-iosevka-term`, `font-google-noto-sans-cjk`.
- **Browsers**: `firefox`, `ungoogled-chromium`.

---

## File Structure

A brief overview of key files:
- **`README.md`**: Contains high-level documentation.
- **`install.sh`**: A script for setting up the system and user configurations on a fresh system.
- **`config/nvim/lua/config.lua`**: Neovim configuration file with plugin, theme, and LSP settings.
- **`config/fish/config.fish`**: Shell configuration file for Fish.
- **`systems/*.scm`**: Guix System configurations.

---

## Contribution

This is a personal configuration repository but feel free to suggest improvements or report issues.

---

## License

This repository does not have a license file, so it is proprietary by default.

---

For any questions or assistance, visit the [GitHub repository](https://github.com/get-state/guix-config).
```
