#!/bin/bash

# inwx_add_a.bash inwxapi inwxlogin inwxpasswd name tld ipv4 ttl

python ./python2.7-client/update_ns_record.py "$1" "$2" "$3" "add" "$4" "$5" "A" "$6" $7



