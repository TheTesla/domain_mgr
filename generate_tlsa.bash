#!/bin/bash

source inwx_config.bash
source domain_config.bash
source le_paths.bash

for fulldomain in $(ls $certbasepath)
do
  certfile=$certbasepath/$fulldomain/$certname
  tlsarecords=$(./chaingen.bash $certfile $fulldomain:0 | grep -oP 'TLSA.*' | sed 's/TLSA //')
  while IFS= read -r tlsa 
  do
    echo "${tlsa}"
    ./inwx_add_tlsa.bash $api $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${tlsa}" '*' 600
  done <<< "${tlsarecords}" 

done


