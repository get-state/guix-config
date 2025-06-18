^script -qec "bash -l -c 'source /home/mazin/.profile && env'" /dev/null
| lines 
| parse "{name}={value}"
| where name != "PWD" 
| reduce -f {} {|it, acc| $acc | insert $it.name $it.value} 
| load-env
