#!/bin/bash

# inwx_add_dkim.bash inwxapi inwxlogin inwxpasswd name tld entry keyname ttl

python ./python2.7-client/update_ns_record.py "$1" "$2" "$3" "add" "_$7._domainkey.$4" "$5" "TXT" "$6" $8



