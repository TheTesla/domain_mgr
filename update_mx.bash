#!/bin/bash

source inwx_config.bash
source domain_config.bash
#source get_ips.bash

. ./primdomain.bash


for fulldomain in $domainlist
do
  echo "qry mx"
  mxrecord=$fulldomain
  prio=10
  oldmxrecords=$(./inwx_qry_mx.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) | sort)

  ./inwx_add_mx.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${mxrecord}" $prio 600

  if [ "$oldmxrecords" ]
  then

    difference=$(comm -3 <(echo "$oldmxrecords") <(echo "$mxrecord"))
    if [ "$difference" ]
    then

      while IFS= read -r mx
      do
        echo "delete: ${mx}"
        ./inwx_del_mx.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${mx}"
      done <<< "${oldmxrecords}" 
    fi
  fi
    

done



