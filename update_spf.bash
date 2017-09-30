#!/bin/bash

source inwx_config.bash
source domain_config.bash
source get_ips.bash

. ./primdomain.bash


for fulldomain in $domainlist
do
  echo "qry txt"
  spfrecord="v=spf1"
  if [ "$ipv4" ]
  then
    spfrecord="$spfrecord ipv4:$ipv4"
  fi
  if [ "$ipv6" ]
  then
    spfrecord="$spfrecord ipv6:$ipv6"
  fi
    spfrecord="$spfrecord ?all"
  oldspfrecords=$(./inwx_qry_txt.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev)| grep "v=spf1" | sort)

  ./inwx_add_txt.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${spfrecord}" 600

  if [ "$oldspfrecords" ]
  then

    difference=$(comm -3 <(echo "$oldspfrecords") <(echo "$spfrecord"))
    if [ "$difference" ]
    then

      while IFS= read -r spf
      do
        echo "delete: ${spf}"
        ./inwx_del_txt.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${spf}"
      done <<< "${oldspfrecords}" 
    fi
  fi
    

done



