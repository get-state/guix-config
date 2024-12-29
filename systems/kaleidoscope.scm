(define-module (systems kaleidoscope)
  #:use-module (systems base-system)
  #:use-module (gnu services linux)
  #:use-module (gnu)
  #:use-module (guix))

(operating-system
  (inherit base-system)
  (services
   (append (list (simple-service 'super-io kernel-module-loader-service-type
                                 '("nct6775"))) default-services))
  (host-name "kaleidoscope"))
