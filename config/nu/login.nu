^script -qec "bash -c -l 'source /home/mazin/.profile && source /run/current-system/profile/etc/profile.d/nix.sh && env'" /dev/null
| lines 
| parse "{name}={value}"
| where name != "PWD" 
| reduce -f {} {|it, acc| $acc | insert $it.name $it.value} 
| load-env

# $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
