#!/bin/bash

# inxwupdate.bash inwxapi inwxlogin inwxpasswd name tld ipv4 ipv6 dkimkey ttl

python /root/inwx-client/update_ns_record.py "$1" "$2" "$3" "del" "_*._tcp.$4" "$5" "TLSA" "$6"


