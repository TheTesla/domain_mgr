#!/bin/bash

dkim_keysize=2048
dkim_keyname=$(date '+%Y_%m_%d__%H_%M_%S\')

source domain_config.bash
source inwx_config.bash

rspamadm dkim_keygen -b $dkim_keysize -s 2017 -k /var/lib/rspamd/dkim/$dkim_keyname.key > /var/lib/rspamd/dkim/$dkim_keyname.txt

chmod 440 /var/lib/rspamd/dkim/*

echo "-- dkim key entry --"

cat /var/lib/rspamd/dkim/$dkim_keyname.txt

dkimkey=$(sed ':a;N;$!ba;s/\n/ /g' $dkim_keyname.txt | grep -oP "\".*" | sed "s/[\"\t \)]//g" | sed "s/;$//g" | sed "s/;/; /g")

./inwx_add_dkim.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "${dkimkey}" $dkim_keyname 600 

echo "selector = \"$dkim_keyname\";" > /var/lib/rspamd/dkim_signing_selector_new.conf

