(define-module (systems kaleidoscope)
  #:use-module (systems base-system)
  #:use-module (gnu services linux)
  #:use-module (nongnu services nvidia)
  #:use-module (gnu))

(operating-system
  (inherit base-system)
  (host-name "avalon"))
