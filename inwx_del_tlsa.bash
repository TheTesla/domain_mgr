#!/bin/bash

python ./python2.7-client/update_ns_record.py "$1" "$2" "$3" "del" "$7._tcp.$4" "$5" "TLSA" "$6"


