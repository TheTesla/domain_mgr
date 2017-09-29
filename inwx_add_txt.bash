#!/bin/bash

# inwx_add_txt.bash inwxapi inwxlogin inwxpasswd name tld entry ttl

python ./python2.7-client/update_ns_record.py "$1" "$2" "$3" "add" "$4" "$5" "TXT" "$6" $7



