#!/bin/bash

source dkim_conf.bash
source domain_config.bash
source inwx_config.bash


dkim_keynumbers=$(ls $dkim_keylocation/$dkim_keybasename*.key | sed "s/[^0-9]//g" | sort -g | head -n -1)

for n in $dkim_keynumbers
do
  dkim_keyname="$dkim_keybasename$n"
  for fulldomain in $domainlist
  do
    ./inwx_del_dkim.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) $dkim_keyname
  done
  rm $dkim_keylocation/$dkim_keyname.key
  rm $dkim_keylocation/$dkim_keyname.txt
done


