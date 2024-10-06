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
             (gnu home services gnupg)
             (gnu home services ssh)
             (rnrs io ports)
             (gnu services shepherd)
             (guix gexp)
             (gnu home services shells))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "feh"
                                            "lf"
                                            "git"
                                            "neovim"
                                            "font-iosevka-term"
                                            "font-atkinson-hyperlegible"
                                            "ungoogled-chromium"
                                            "firefox"
                                            "xcalib"
                                            "xclip"
                                            "curl"
                                            "feh"
                                            "picom"
                                            "ncmpcpp"
                                            "mpd"
                                            "gimp"
                                            "openssh"
                                            "bibata-cursor-theme"
                                            "easyeffects"
                                            "file"
                                            "zathura"
                                            "zathura-pdf-mupdf"
                                            "file"
                                            "pulsemixer"
                                            "ncdu"
                                            "rbw"
                                            "dconf"
                                            "pinentry-tty"
                                            "font-google-noto"
                                            "font-google-noto-sans-cjk"
                                            "ranger"
                                            "intel-media-driver"
                                            "xrdb"
                                            "gnupg"
                                            "direnv"
                                            "aerc"
                                            "mpv")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '(("grep" . "grep --color=auto")
                              ("ip" . "ip -color=auto")
                              ("ll" . "ls -l")
                              ("ls" . "ls -p --color=auto")))
                   (bashrc (list (local-file "./.bashrc" "bashrc")))
                   (bash-profile (list (local-file "./.bash_profile"
                                                   "bash_profile")))))

         (service home-shepherd-service-type
                  (home-shepherd-configuration (services (list (shepherd-service
                                                                (provision '(mpd))
                                                                (start #~(make-system-constructor
                                                                          "mpd"))
                                                                (stop #~(make-system-destructor
                                                                         "mpd"
                                                                         "--kill"))
                                                                (documentation
                                                                 "Start the Music Player Daemon"))))))

         (simple-service 'xdg-user-directories-config-service
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

         ;; Dbus is needed as a dependency
         (service home-dbus-service-type)
         ;; Configure pipewire service, should enable pulseaudio
         (service home-pipewire-service-type)

         (service home-fish-service-type
                  (home-fish-configuration (config (list (local-file
                                                          "config/fish/config.fish")))))

         (simple-service 'some-useful-env-vars-service
                         home-environment-variables-service-type
                         `(("EDITOR" . "nvim")))

         (service home-gpg-agent-service-type
                  (home-gpg-agent-configuration (pinentry-program (file-append
                                                                   pinentry-tty
                                                                   "/bin/pinentry-tty"))
                                                (ssh-support? #f)))

         (service home-openssh-service-type
                  (home-openssh-configuration (add-keys-to-agent "yes")))

         (service home-ssh-agent-service-type
                  (home-ssh-agent-configuration (extra-options '("-t" "1h30m"))))

	 (simple-service `home-config home-files-service-type 
			 `((".xinitrc" , (local-file "config/xinitrc"))))


         (simple-service `wm-config home-xdg-configuration-files-service-type
                         `(("i3/config" ,(local-file "config/i3/config"))
                           ("alacritty.toml" ,(local-file
                                               "config/alacritty/alacritty.toml"))

                           ("fontconfig/conf.d/99-fonts.conf" ,(local-file
                                                                "config/fontconfig/fonts.conf"))
                           ("picom/picom.conf" ,(local-file
                                                 "config/picom/picom.conf"))
                           ("polybar/shades" ,(local-file "config/shades"
                                                          #:recursive? #t))
                           ;; ("nvim" ,(local-file "config/nvim"
                           ;; #:recursive? #t))
                           
                           ;; ("fish/functions" ,(local-file "config/fish/functions"
                           ;; #:recursive? #t))
                           ;; ("fish/completions" ,(local-file "config/fish/completions"
                           ;; #:recursive? #t))
                           ;; ("fish/conf.d" ,(local-file "config/fish/conf.d"
                           ;; #:recursive? #t))
                           ;; ("fish/fish_variables" ,(local-file "config/fish/fish_variables"))
                           ("mpd" ,(local-file "config/mpd"
                                               #:recursive? #t))
                           ("ncmpcpp" ,(local-file "config/ncmpcpp"
                                                   #:recursive? #t)))))))
