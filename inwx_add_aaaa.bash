#!/bin/bash

# inwx_add_aaaa.bash inwxapi inwxlogin inwxpasswd name tld ipv6 ttl

python ./python2.7-client/update_ns_record.py "$1" "$2" "$3" "add" "$4" "$5" "AAAA" "$6" $7



