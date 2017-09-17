#!/bin/bash

# inwx_del_aaaa.bash inwxapi inwxlogin inwxpasswd name tld ipv6 

python ./python2.7-client/update_ns_record.py "$1" "$2" "$3" "del" "$4" "$5" "AAAA" "$6" 




