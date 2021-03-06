#!/bin/bash

source inwx_config.bash
source le_paths.bash
source domain_config.bash

. ./primdomain.bash

for fulldomain in $domainlist
do
  certfile=$certbasepath/$primdomain/$certname
  echo "$certfile"
  oldtlsarecords=$(./inwx_qry.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "*" | sort)
  tlsarecords=$(./chaingen.bash $certfile $fulldomain:0 | grep -oP 'TLSA.*' | sed 's/TLSA[[:space:]]//' | sort)
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
        ./inwx_del_tlsa.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${tlsa}" "*"
      done <<< "${difference}" 
    fi
  fi
done


