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
         (name 'tailscale)
         (url "https://github.com/umanwizard/guix-tailscale")
         (branch "main")
         (introduction
          (make-channel-introduction
           "c72e15e84c4a9d199303aa40a81a95939db0cfee"
           (openpgp-fingerprint "9E53FC33B8328C745E7B31F70226C10D7877B741"))))
       %default-channels)
