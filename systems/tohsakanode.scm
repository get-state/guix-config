(define-module (config systems tohsakanode)
#:use-module (systems base-system)
#:use-module (gnu)
#:use-module (guix))

(operating-system
  (inherit base-system)
  (host-name "tohsakanode")
  (services laptop-services)
  (keyboard-layout (keyboard-layout "uk"
                                    #:options '("ctrl:nocaps"))))
