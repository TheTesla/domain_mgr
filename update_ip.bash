#!/bin/bash

source inwx_config.bash
source domain_config.bash

. ./primdomain.bash

arecord=$(curl ipv4.icanhazip.com)
aaaarecord=$(curl ipv6.icanhazip.com)

for fulldomain in $domainlist
do
  echo "qry a"
  oldarecords=$(./inwx_qry_a.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) | sort)
  echo "qry aaaa"
  oldaaaarecords=$(./inwx_qry_aaaa.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) | sort)

  echo ${oldarecords} 
  echo ${arecords}
  for oldarecord in $oldarecords
  do
    if [ "$oldarecord" != "$arecord" ]
    then
      echo "del a"
      ./inwx_del_a.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) $oldarecord
    fi
  done
   
  echo "add a"
  ./inwx_add_a.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) $arecord
  
  echo ${oldaaaarecords} 
  echo ${aaaarecords} 
  for oldaaaarecord in $oldaaaarecords
  do
    if [ "$oldaaaarecord" != "$aaaarecord" ]
    then
      echo "del aaaa"
      ./inwx_del_aaaa.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) $oldaaaarecord
    fi
  done
    
  echo "add aaaa"
  ./inwx_add_aaaa.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) $aaaarecord
  

done



