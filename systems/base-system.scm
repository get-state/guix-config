;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS, and a swap file.
(define-module (systems base-system)
  #:use-module (gnu)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages hardware)
  #:use-module (gnu services ssh)
  #:use-module (gnu services audio)
  #:use-module (gnu services xorg)
  #:use-module (gnu services pm)
  #:use-module (gnu services nix)
  #:use-module (gnu services security-token)
  #:use-module (gnu system nss)
  #:use-module (guix utils)
  #:export (default-services base-system laptop-services))

(use-service-modules desktop)
(use-package-modules bootloaders
                     certs
                     wm
                     xorg
                     terminals
                     package-management
                     suckless
                     vim)

(define default-services
  (append (list (service startx-command-service-type
                         (xorg-configuration (drivers (list "modesetting"))))
                (service openssh-service-type
                         (openssh-configuration))
                (service screen-locker-service-type
                         (screen-locker-configuration (name "i3lock")
                                                      (program (file-append
                                                                slock
                                                                "/bin/i3lock"))))
                (service nix-service-type)
                (service pcscd-service-type))
          (modify-services %desktop-services
            (guix-service-type config =>
                               (guix-configuration (inherit config)
                                                   (substitute-urls (append (list
                                                                             "https://substitutes.nonguix.org")
                                                                     %default-substitute-urls))
                                                   (authorized-keys (append (list
                                                                             (local-file
                                                                              "../signing-key.pub"))
                                                                     %default-authorized-guix-keys))))
            (delete gdm-service-type))))

(define laptop-services
  (append (list (udev-rules-service 'brillo brillo)
                (service tlp-service-type
                         (tlp-configuration (cpu-scaling-governor-on-ac (list
                                                                         "schedutil"))
                                            (sched-powersave-on-bat? #t))))
          default-services))

(define base-system
  (operating-system
    (host-name "base-system")
    (timezone "Asia/Bahrain")
    (locale "en_US.utf8")
    (kernel linux)
    (initrd microcode-initrd)
    (firmware (list linux-firmware))

    ;; Choose US English keyboard layout.  The "altgr-intl"
    ;; variant provides dead keys for accented characters.
    (keyboard-layout (keyboard-layout "us"))

    ;; Use the UEFI variant of GRUB with the EFI System
    ;; Partition mounted on /boot/efi.
    (bootloader (bootloader-configuration
                  (bootloader grub-efi-bootloader)
                  (targets '("/boot/EFI"))
                  (keyboard-layout keyboard-layout)))

    (file-systems (append (list (file-system
                                  (device (file-system-label "data"))
                                  (mount-point "/")
                                  (type "btrfs")
                                  (options "subvol=root"))
                                (file-system
                                  (device (file-system-label "data"))
                                  (mount-point "/home")
                                  (type "btrfs")
                                  (options "subvol=home"))
                                (file-system
                                  (device (file-system-label "data"))
                                  (mount-point "/.snapshots")
                                  (type "btrfs")
                                  (options "subvol=snapshots"))
                                (file-system
                                  (device (file-system-label "EFI"))
                                  (mount-point "/boot/EFI")
                                  (type "vfat"))) %base-file-systems))

    ;; Specify a swap file for the system, which resides on the
    ;; root file system.
    (swap-devices (list (swap-space
                          (target (file-system-label "swap")))))

    ;; Create user mazin with no initial password.
    (users (cons (user-account
                   (name "mazin")
                   (comment "")
                   (group "users")
                   (password #f)
                   (shell (file-append fish "/bin/fish"))
                   (supplementary-groups '("wheel" "netdev" "audio" "video")))
                 %base-user-accounts))

    ;; This is where we specify system-wide packages.
    (packages (append (list
                       ;; for i3wm
                       i3-wm
                       i3status
                       dmenu
                       xterm
                       alacritty
                       brillo
                       fish
                       fish-foreign-env
                       nix
                       polybar
                       i3lock
                       neovim) %base-packages))

    (services
     default-services)

    ;; Allow resolution of '.local' host names with mDNS.
    (name-service-switch %mdns-host-lookup-nss)))
