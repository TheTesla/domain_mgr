#!/bin/bash

# inwx_del_a.bash inwxapi inwxlogin inwxpasswd name tld ipv4 

python ./python2.7-client/update_ns_record.py "$1" "$2" "$3" "del" "$4" "$5" "A" "$6"



