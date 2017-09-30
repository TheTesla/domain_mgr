#!/bin/bash

source inwx_config.bash
source domain_config.bash

. ./primdomain.bash


for fulldomain in $domainlist
do
  echo "qry txt"
  adsprecord="dkim=all"
  oldadsprecords=$(./inwx_qry_txt.bash $inwxapi $inwxlogin $inwxpasswd "_adsp._domainkey.$(echo $fulldomain | rev | cut -d. -f3- | rev)" $(echo $fulldomain | rev | cut -d. -f-2 | rev) | sort)

  ./inwx_add_txt.bash $inwxapi $inwxlogin $inwxpasswd "_adsp._domainkey.$(echo $fulldomain | rev | cut -d. -f3- | rev)" $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${adsprecord}" 600

  if [ "$oldadsprecords" ]
  then

    difference=$(comm -3 <(echo "$oldadsprecords") <(echo "$adsprecord"))
    if [ "$difference" ]
    then

      while IFS= read -r adsp
      do
        echo "delete: ${adsp}"
        ./inwx_del_txt.bash $inwxapi $inwxlogin $inwxpasswd "_adsp._domainkey.$(echo $fulldomain | rev | cut -d. -f3- | rev)" $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${adsp}"
      done <<< "${oldadsprecords}" 
    fi
  fi
    

done



