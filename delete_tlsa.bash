#!/bin/bash

source inwx_config.bash
source le_paths.bash


for fulldomain in $(ls $certbasepath)
do
  certfile=$certbasepath/$fulldomain/$certname
  oldtlsarecords=$(/root/inwx_qry.bash $api $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) | sort)
  tlsarecords=$(/root/chaingen.bash $certfile $fulldomain:0 | grep -oP 'TLSA.*' | sed 's/TLSA[[:space:]]//' | sort)
  if [ "$oldtlsarecords" ]
  then
    difference=$(comm -3 <(echo "$oldtlsarecords") <(echo "$tlsarecords"))
    if [ "$difference" ]
    then
      echo "dns query"
      echo "${oldtlsarecords}"
      echo "new records"
      echo "${tlsarecords}"
      echo "difference"
      echo "${difference}"
      echo "end"
      while IFS= read -r tlsa
      do
        echo "delete: ${tlsa}"
        /root/inwx_del_tlsa.bash $api $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${tlsa}"
      done <<< "${difference}" 
    fi
  fi
done


