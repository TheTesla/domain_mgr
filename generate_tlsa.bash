#!/bin/bash

source inwx_config.bash
source domain_config.bash
source le_paths.bash

. ./primdomain.bash

for fulldomain in $domainlist
do
  certfile=$certbasepath/$primdomain/$certname
  tlsarecords=$(./chaingen.bash $certfile $fulldomain:0 | grep -oP 'TLSA.*' | sed 's/TLSA //')
  while IFS= read -r tlsa 
  do
    echo "${tlsa}"
    ./inwx_add_tlsa.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${tlsa}" '*' 600
  done <<< "${tlsarecords}" 

done


