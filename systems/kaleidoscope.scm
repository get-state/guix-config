(define-module (systems kaleidoscope)
  #:use-module (systems base-system)
  #:use-module (gnu)
  #:use-module (gnu services linux)
  #:use-module (guix))

(operating-system
  (inherit base-system)
  (services
   (append (list (simple-service 'superio kernel-module-loader-service-type
                                 '("nct6775"))) default-services))
  (host-name "kaleidoscope"))
