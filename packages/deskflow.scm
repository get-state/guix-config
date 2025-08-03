(define-module (packages deskflow)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix build-system qt)
  #:use-module (gnu packages)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages ninja)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages check)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages vulkan)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages web))

(define-public libportal-0.9
  (package
    (inherit libportal)
    (name "libportal")
    (version "0.9.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/flatpak/libportal")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1rbqkmvvfig98ig8gsf93waiizrminj7gywxbza15hzx3an3hwh9"))))
    (license license:lgpl2.1+)))

(define-public deskflow
  (package
    (name "deskflow")
    (version "1.22.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/deskflow/deskflow/archive/refs/tags/" "v"
             version ".tar.gz"))
       (sha256
        (base32 "1wy1l09s0nnx23dmhp8ijl199xkfj508ch7f3wms3fa3lxmxzxjz"))))
    (build-system qt-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
    (replace 'check
      (lambda _
        (wrap-program "./bin/legacytests" 
                      '("QT_QPA_PLATFORM" ":" = ("offscreen")))
        (invoke "./bin/legacytests"))) 
          (add-after 'unpack 'patch-paths
            (lambda _
              (substitute* "src/lib/deskflow/unix/AppUtilUnix.cpp"
                (("/usr/share/X11/xkb/rules/evdev.xml")
                 #$(file-append xkeyboard-config
                                "/share/X11/xkb/rules/evdev.xml")))
              (substitute* "deploy/linux/deploy.cmake"
                (("message\\(FATAL_ERROR \"Unable to read file /etc/os-release\"\\)")
                 "set(RELEASE_FILE_CONTENTS \"\")")))))))

    (inputs (list qtbase
                  qttranslations
                  qtsvg
                  openssl-3.0
                  libx11
                  libxtst
                  libxinerama
                  libxrandr
                  libxkbcommon
                  libxkbfile
                  glib
                  mesa
                  vulkan-headers
                  tomlplusplus
                  libportal-0.9
                  cli11
                  libei
                  libxi
                  python-3.11
                  pugixml
                  wayland
                  wayland-protocols
                  libsm
                  libice
                  sysprof
                  ))
    (native-inputs (list ninja doxygen pkg-config googletest))
    (synopsis "Hello, GNU world: An example GNU package")
    (description
     "Deskflow is a free and open source keyboard and mouse sharing app. Use the keyboard, mouse, or trackpad of one computer to control nearby computers, and work seamlessly between them. It's like a software KVM (but without the video). TLS encryption is enabled by default. Wayland is supported. Clipboard sharing is supported.")
    (home-page "https://github.com/deskflow/deskflow")
    (license license:gpl2)))
