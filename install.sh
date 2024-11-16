cp ./config/guix/channels.scm /etc/guix/channels.scm
guix pull -c 12
guix archive --authorize < ./signing-key.pub
hash guix
herd start cow-store /mnt
guix time-machine -C ./channel-lock.scm -- system init --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org' /mnt/etc/guix-config/system-configuration.scm /mnt
mkdir -p /mnt/etc/guix
cp ./config/guix/channels.scm /mnt/etc/guix/channels.scm
