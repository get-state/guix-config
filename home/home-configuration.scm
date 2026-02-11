;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu packages gnupg)
             (gnu services)
             (gnu home services)
             (gnu home services xdg)
             (gnu home services shepherd)
             (gnu home services sound)
             (gnu home services desktop)
             (gnu packages xdisorg)
             (gnu home services gnupg)
             (gnu home services ssh)
             (gnu services shepherd)
             (gnu home services shells)
             (guix gexp)
             (rnrs io ports)
             (abbe packages golang))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "feh"
                                            "git"
                                            "font-iosevka-term"
                                            "font-atkinson-hyperlegible"
                                            "adwaita-icon-theme"
                                            "hicolor-icon-theme"
                                            "ppsspp"
                                            "ueberzugpp"
                                            "qogir-icon-theme"
                                            "gnome-themes-extra"
                                            "github-cli"
                                            "carapace-bin"
                                            "bat"
                                            "firefox"
                                            "xcalib"
                                            "xclip"
                                            "pinfo"
                                            "xmodmap"
                                            "curl"
                                            "deluge"
                                            "picom"
                                            "ncmpcpp"
                                            "mpd"
                                            "gimp"
                                            "openssh"
                                            "imv"
                                            "sway"
                                            "scrcpy"
                                            "signal-desktop"
                                            "xdg-utils"
                                            "libreoffice"
                                            "yazi"
                                            "b4"
                                            "bibata-cursor-theme"
                                            "file"
                                            "fzf"
                                            "ripgrep"
                                            "zathura"
                                            "distrobox"
                                            "lutris-wrapped"
                                            "bitwarden-desktop"
                                            "intel-media-driver-nonfree"
                                            "rbw"
                                            "zathura-pdf-mupdf"
                                            "zathura-djvu"
                                            "newsboat"
                                            "file"
                                            "pulsemixer"
                                            "steam"
                                            "ncdu"
                                            "alsa-utils"
                                            "brillo"
                                            "rbw"
                                            "dconf"
                                            "pinentry-tty"
                                            "font-google-noto"
                                            "font-google-noto-sans-cjk"
                                            "ranger"
                                            "htop"
                                            "senpai"
                                            "maim"
                                            "man-pages"
                                            "xrdb"
                                            "gnupg"
                                            "direnv"
                                            "aerc"
                                            "mpv")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (append (list (simple-service 'xdg-user-directories-config-service
                                 home-xdg-user-directories-service-type
                                 (home-xdg-user-directories-configuration (desktop
                                                                           "$HOME/Desktop")
                                                                          (documents
                                                                           "$HOME/Documents")
                                                                          (download
                                                                           "$HOME/Downloads")
                                                                          (music
                                                                           "$HOME/Music")
                                                                          (pictures
                                                                           "$HOME/Pictures")
                                                                          (publicshare
                                                                           "$HOME/Public")
                                                                          (templates
                                                                           "$HOME/Templates")
                                                                          (videos
                                                                           "$HOME/Videos")))

                 ;; Dbus is needed as a dependency for pipewire
                 (service home-dbus-service-type)
                 ;; Configure pipewire service, should enable pulseaudio
                 (service home-pipewire-service-type)

                 (service home-fish-service-type
                          (home-fish-configuration (config (list (local-file
                                                                  "../config/fish/config.fish")))))

                 (simple-service 'some-useful-env-vars-service
                                 home-environment-variables-service-type
                                 `(("EDITOR" . "nvim")
                                   ("QT_QPA_PLATFORMTHEME" . "gtk3")
                                   ("GTK_THEME" . "Adwaita:dark")
                                   ("TERMINAL" . "alacritty -e")))

                 (service home-gpg-agent-service-type
                          (home-gpg-agent-configuration (pinentry-program (file-append
                                                                           pinentry-tty
                                                                           "/bin/pinentry-curses"))
                                                        (ssh-support? #f)))

                 (service home-shepherd-service-type
                          (home-shepherd-configuration (services (list (shepherd-service
                                                                        (provision '
                                                                         (mpd))

                                                                        (start #~
                                                                         (make-system-constructor
                                                                          "mpd")))))))

                 (service home-openssh-service-type
                          (home-openssh-configuration (add-keys-to-agent "yes")))

                 (service home-ssh-agent-service-type
                          (home-ssh-agent-configuration (extra-options '("-t"
                                                                         "1h30m"))))

                 (service home-x11-service-type)

                 (simple-service 'carapace-nushell-setup
                                 home-activation-service-type
                                 #~(begin
                                     (let ((cache-dir (string-append (getenv
                                                                      "HOME")
                                                       "/.cache/nushell")))
                                       (mkdir-p cache-dir)
                                       (system (string-append #$carapace
                                                "/bin/carapace _carapace nushell > "
                                                cache-dir "/carapace.nu")))))

                 (service home-unclutter-service-type
                          (home-unclutter-configuration (unclutter
                                                         unclutter-xfixes)
                                                        (idle-timeout 8)))

                 ;; Moves fonts and other configs in $HOME.
                 (simple-service `home-config home-files-service-type
                                 `((".xinitrc" ,(local-file
                                                 "../config/other/xinitrc"))
                                   (".Xresources" ,(local-file
                                                    "../config/other/Xresources"))
                                   (".config/nushell/config.nu" ,(local-file
                                                         "../config/nu/config.nu"))
                                   (".gtkrc-2.0" ,(local-file
                                                   "../config/other/gtkrc-2.0"))
                                   (".local/share/fonts" ,(local-file
                                                           "../config/fonts"
                                                           #:recursive? #t))))

                 ;; Handles configs that adhere to XDG.
                 (simple-service `wm-config
                                 home-xdg-configuration-files-service-type
                                 `(("i3/config" ,(local-file
                                                  "../config/i3/config-carbon"))
                                   ("sway/config" ,(local-file
                                                    "../config/sway/config"))
                                   ("alacritty.toml" ,(local-file
                                                       "../config/alacritty/alacritty-carbon.toml"))

                                   ("nushell/login.nu" ,(local-file
                                                         "../config/nu/login.nu"))

                                   ("fontconfig/conf.d/99-fonts.conf" ,(local-file
                                                                        "../config/fontconfig/fonts.conf"))
                                   ("picom/picom.conf" ,(local-file
                                                         "../config/picom/picom.conf"))

                                   ("nix/nix.conf" ,(local-file
                                                     "../config/nix/nix.conf"))

                                   ("gtk-3.0/settings.ini" ,(local-file
                                                             "../config/other/gtk3-settings.ini"))

                                   ("mimeapps.list" ,(local-file
                                                      "../config/mime/mimeapps.list"))

                                   ("pipewire/pipewire.conf.d" ,(local-file
                                                                 "../config/pipewire"
                                                                 #:recursive?
                                                                 #t))

                                   ("polybar/shades" ,(local-file
                                                       "../config/shades"
                                                       #:recursive? #t))

                                   ("newsboat" ,(local-file
                                                 "../config/newsboat"
                                                 #:recursive? #t))

                                   ("lf" ,(local-file "../config/lf"
                                                      #:recursive? #t))

                                   ;; ("aerc" ,(local-file "../config/aerc"
                                   ;; #:recursive? #t))
                                   
                                   ("ncmpcpp" ,(local-file "../config/ncmpcpp"
                                                #:recursive? #t)))))
           %base-home-services)))
