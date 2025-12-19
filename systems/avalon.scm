(define-module (systems kaleidoscope)
  #:use-module (systems base-system)
  #:use-module (gnu))

(operating-system
  (inherit base-system)
  (host-name "avalon"))
