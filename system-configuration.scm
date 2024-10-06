;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS, and a swap file.

(use-modules (gnu)
             (nongnu packages linux)
             (gnu packages shells)
             (gnu services xorg)
             (gnu system nss)
             (guix utils))
(use-service-modules desktop)
(use-package-modules bootloaders
                     certs
                     wm
                     xorg
                     terminals
                     suckless
                     vim)

(operating-system
  (host-name "mazin-desktop")
  (timezone "Asia/Bahrain")
  (locale "en_US.utf8")
  (kernel linux)
  (firmware (list linux-firmware))

  ;; Choose US English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

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
                                (mount-point "/mnt/.snapshots")
                                (type "btrfs")
                                (options "subvol=snapshots"))
                              (file-system
                                (device (file-system-label "data"))
                                (mount-point "/mnt/var")
                                (type "btrfs")
                                (options "subvol=var"))
                              (file-system
                                (device (file-system-label "EFI"))
                                (mount-point "/boot/EFI")
                                (type "vfat"))) %base-file-systems))

  ;; Specify a swap file for the system, which resides on the
  ;; root file system.
  (swap-devices (list (swap-space
                        (target (file-system-label "swap")))))

  ;; Create user `bob' with `alice' as its initial password.
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
                     fish
                     fish-foreign-env
                     polybar
                     i3lock
                     neovim) %base-packages))

  (services
   (append (list (service startx-command-service-type
                          (xorg-configuration (drivers (list "modesetting")))))
           (modify-services %desktop-services
             (guix-service-type config =>
                                (guix-configuration (inherit config)
                                                    (substitute-urls (append (list
                                                                              "https://substitutes.nonguix.org")
                                                                      %default-substitute-urls))
                                                    (authorized-keys (append (list
                                                                              (local-file
                                                                               "./signing-key.pub"))
                                                                      %default-authorized-guix-keys))))
             (delete gdm-service-type))))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
