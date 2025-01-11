(define-module (packages neovim)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages tree-sitter)
  #:use-module (guix licenses))

(define-public tree-sitter-0.24
  (package
    (inherit tree-sitter)
    (version "0.24.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/tree-sitter/tree-sitter")
             (commit (string-append "v" version))))
       (sha256
        (base32 "06h4gzia4fb04a59llxrch63k4sbhz17ickqmmr9qggy58cdk7aj"))))))

(define-public neovim-0.10
  (package
    (inherit neovim)
    (version "0.10.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/neovim/neovim")
             (commit (string-append "v" version))))
       (sha256
        (base32 "01646f9wa47dmpcx8gpgzaxhz8bm6z44y9m9ixiwrw2dk1lsilcs"))))
    (inputs (modify-inputs (package-inputs neovim)
              (replace "tree-sitter" tree-sitter-0.24)))))
