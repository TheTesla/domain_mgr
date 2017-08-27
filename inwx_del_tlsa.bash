#!/bin/bash

python ./inwx-client/update_ns_record.py "$1" "$2" "$3" "del" "_*._tcp.$4" "$5" "TLSA" "$6"


