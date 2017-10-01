#!/bin/bash

# inwx_add_mx.bash inwxapi inwxlogin inwxpasswd name tld entry prio ttl

python ./python2.7-client/update_ns_record.py "$1" "$2" "$3" "add" "$4" "$5" "MX" "$6" $8 $7



