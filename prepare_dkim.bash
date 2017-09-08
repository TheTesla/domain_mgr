#!/bin/bash

dkim_keysize=2048
dkim_keyname=$(date '+%Y_%m_%d__%H_%M_%S\')
dkim_keylocation=/var/lib/rspamd/dkim

source domain_config.bash
source inwx_config.bash
source le_paths.bash

rspamadm dkim_keygen -b $dkim_keysize -s 2017 -k $dkim_keylocation/$dkim_keyname.key > $dkim_keylocation/$dkim_keyname.txt

chmod 440 $dkim_keylocation/*

echo "-- dkim key entry --"

cat $dkim_keylocation/$dkim_keyname.txt

dkimkey=$(sed ':a;N;$!ba;s/\n/ /g' $dkim_keylocation/$dkim_keyname.txt | grep -oP "\".*" | sed "s/[\"\t \)]//g" | sed "s/;$//g" | sed "s/;/; /g")

for fulldomain in $(ls $certbasepath)
do
  ./inwx_add_dkim.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "$dkimkey" $dkim_keyname 600 
done

echo "selector = \"$dkim_keyname\";" > /var/lib/rspamd/dkim_signing_selector_new.conf

