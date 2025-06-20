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
       (channel
         (name 'saayix)
         (branch "main")
         (url "https://codeberg.org/look/saayix")
         (introduction
          (make-channel-introduction
           "12540f593092e9a177eb8a974a57bb4892327752"
           (openpgp-fingerprint
            "3FFA 7335 973E 0A49 47FC  0A8C 38D5 96BE 07D3 34AB"))))
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
       %default-channels)
