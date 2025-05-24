(list (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        (branch "master")
        (commit
          "ff1ede27b0514724212b310a0ce248b5ff2158ab")
        (introduction
          (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
              "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
      (channel
        (name 'tailscale)
        (url "https://github.com/umanwizard/guix-tailscale")
        (branch "main")
        (commit
          "d0b1b05fdcf1407da72db803bf08fa6f223f9bae")
        (introduction
          (make-channel-introduction
            "c72e15e84c4a9d199303aa40a81a95939db0cfee"
            (openpgp-fingerprint
              "9E53 FC33 B832 8C74 5E7B  31F7 0226 C10D 7877 B741"))))
      (channel
        (name 'small-guix)
        (url "https://codeberg.org/fishinthecalculator/small-guix.git")
        (branch "main")
        (commit
          "ee0784433a5f9f9b268a8be770c26a5d9bfc1b9a")
        (introduction
          (make-channel-introduction
            "f260da13666cd41ae3202270784e61e062a3999c"
            (openpgp-fingerprint
              "8D10 60B9 6BB8 292E 829B  7249 AED4 1CC1 93B7 01E2"))))
      (channel
        (name 'guix)
        (url "https://codeberg.org/guix/guix-mirror")
        (branch "master")
        (commit
          "8dff81313876a54519ce17e9fda64d4310e2dd5c")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
