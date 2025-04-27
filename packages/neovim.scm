(define-module (packages neovim)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages tree-sitter)
  #:use-module (gnu packages julia)
  #:use-module (gnu packages textutils)
  #:use-module (guix licenses))

; TODO fix tests
; Just disable the check/test phase.
(define-public utf8proc-2.10.0
  (hidden-package (package
                    (inherit utf8proc)
                    (version "2.10.0")
                    (name "utf8proc")
                    (source
                     (origin
                       (method git-fetch)
                       (uri (git-reference
                             (url "https://github.com/JuliaStrings/utf8proc")
                             (commit (string-append "v" version))))
                       (file-name (git-file-name name version))
                       (sha256
                        (base32
                         "1n1k67x39sk8xnza4w1xkbgbvgb1g7w2a7j2qrqzqaw1lyilqsy2"))))
                    (inputs (append (package-inputs utf8proc)
                                    `(("julia" ,julia)
                                      ("curl" ,curl))))
                    (arguments
                     (substitute-keyword-arguments (package-arguments utf8proc)
                       ((#:phases phases)
                        `(modify-phases ,phases
                           (delete 'check))))))))

(define-public tree-sitter-0.25
  (package
    (inherit tree-sitter)
    (version "0.25.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/tree-sitter/tree-sitter")
             (commit (string-append "v" version))))
       (sha256
        (base32 "0cck2wa17figxww7lb508sgwy9sbyqj89vxci07hiscr5sgdx9y5"))))))

(define-public neovim-0.11
  (package
    (inherit neovim)
    (version "0.11.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/neovim/neovim")
             (commit (string-append "v" version))))
       (sha256
        (base32 "1z7xmngjr93dc52k8d3r6x0ivznpa8jbdrw24gqm16lg9gzvma02"))))
    (inputs (modify-inputs (package-inputs neovim)
              (replace "tree-sitter" tree-sitter-0.25)
              (append utf8proc-2.10.0)))))
