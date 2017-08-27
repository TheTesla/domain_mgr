#!/bin/bash

# inwx_add_tlsa.bash inwxapi inwxlogin inwxpasswd name tld ipv4 tlsa port ttl

python /root/inwx-client/update_ns_record.py "$1" "$2" "$3" "add" "_$7._tcp.$4" "$5" "TLSA" "$6" $8



