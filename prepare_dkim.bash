#!/bin/bash

source dkim_conf.bash

dkim_keynumber=$(($(ls $dkim_keylocation/$dkim_keybasename*.key | sed "s/[^0-9]//g" | sort -g | tail -n 1) + 1))
dkim_keyname="$dkim_keybasename$dkim_keynumber"

echo $dkim_keynumber
echo $dkim_keyname

source domain_config.bash
source inwx_config.bash
source le_paths.bash

rspamadm dkim_keygen -b $dkim_keysize -s $dkim_keyname -k $dkim_keylocation/$dkim_keyname.key > $dkim_keylocation/$dkim_keyname.txt

chmod 440 $dkim_keylocation/*
chown _rspamd:_rspamd $dkim_keylocation/*

echo "-- dkim key entry --"

cat $dkim_keylocation/$dkim_keyname.txt

dkimkey=$(sed ':a;N;$!ba;s/\n/ /g' $dkim_keylocation/$dkim_keyname.txt | grep -oP "\".*" | sed "s/[\"\t \)]//g" | sed "s/;$//g" | sed "s/;/; /g")

for fulldomain in $domainlist
do
  ./inwx_add_dkim.bash $inwxapi $inwxlogin $inwxpasswd $(echo $fulldomain | rev | cut -d. -f3- | rev) $(echo $fulldomain | rev | cut -d. -f-2 | rev) "$dkimkey" $dkim_keyname 600 
done

./dkim_signing_template.bash $dkim_keyname > /etc/rspamd/dkim_signing_new.conf

