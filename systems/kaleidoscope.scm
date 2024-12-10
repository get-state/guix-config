(define-module (systems kaleidoscope)
  #:use-module (systems base-system)
  #:use-module (gnu)
  #:use-module (guix))

(operating-system
  (inherit base-system)
  (host-name "kaleidoscope"))
