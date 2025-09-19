(define-module (systems kaleidoscope)
  #:use-module (systems base-system)
  #:use-module (gnu services linux)
  #:use-module (nongnu services nvidia)
  #:use-module (gnu))

(operating-system
  (inherit base-system)
  (services
   (append (list (service nvidia-service-type)
                 (simple-service 'super-io kernel-module-loader-service-type
                                 '("nct6775"))) default-services))
  (kernel-arguments (append '("modprobe.blacklist=nouveau"
                              ;; Set this if the card is not used for displaying or
                              ;; you're using Wayland:
                              "nvidia_drm.modeset=0")
                            %default-kernel-arguments))
  (host-name "kaleidoscope"))
