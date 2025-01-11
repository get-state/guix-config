(define-module (systems tohsakanode)
  #:use-module (systems base-system)
  #:use-module (gnu)
  #:use-module (gnu services xorg)
  #:use-module (guix))

(operating-system
  (inherit base-system)
  (host-name "tohsakanode")
  (keyboard-layout (keyboard-layout "gb"
                                    #:options '("ctrl:nocaps")))

  (services
   (modify-services laptop-services
     (startx-command-service-type config =>
                                  (xorg-configuration (keyboard-layout
                                                       keyboard-layout))))))

