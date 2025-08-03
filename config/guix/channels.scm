(cons* (channel
         (name 'nonguix)
         (url "https://gitlab.com/nonguix/nonguix")
         ;; Enable signature verification:
         (introduction
          (make-channel-introduction
           "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
           (openpgp-fingerprint
            "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
        (channel
        (name 'abbe)
        (url "https://codeberg.org/group/guix-modules.git")
        (branch "mainline")
        (introduction
          (make-channel-introduction
            "8c754e3a4b49af7459a8c99de130fa880e5ca86a"
            (openpgp-fingerprint
              "F682 CDCC 39DC 0FEA E116  20B6 C746 CFA9 E74F A4B0"))))
       (channel
         (name 'small-guix)
         (url "https://codeberg.org/fishinthecalculator/small-guix.git")
         (branch "main")
         ;; Enable signature verification:
         (introduction
          (make-channel-introduction
           "f260da13666cd41ae3202270784e61e062a3999c"
           (openpgp-fingerprint
            "8D10 60B9 6BB8 292E 829B  7249 AED4 1CC1 93B7 01E2"))))
        (channel
        (name 'guix-hpc-non-free)
        (url "https://gitlab.inria.fr/guix-hpc/guix-hpc-non-free.git"))
       %default-channels)
