#!/bin/bash

source domain_config.bash


systemctl stop apache2
for domain in $domainlist
do
  echo ""
  echo "---- renew: $domain ----"
  echo ""
  ./certbot/certbot-auto certonly --email "$certemail" "$certextra" --force-renewal --agree-tos --non-interactive --standalone --rsa-key-size 4096 -d "$domain"
done
systemctl start apache2

echo ""
echo "---- update all tlsa entries ----"
echo ""

./generate_tlsa.bash


