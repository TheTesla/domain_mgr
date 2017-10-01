#!/bin/bash

# inwx_del_txt.bash inwxapi inwxlogin inwxpasswd name tld entry 

python ./python2.7-client/update_ns_record.py "$1" "$2" "$3" "del" "$4" "$5" "TXT" "$6" 



