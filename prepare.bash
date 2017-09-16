#!/bin/bash

source domain_config.bash


systemctl stop apache2
systemctl stop nginx

combineddomains=""
for domain in $domainlist
do
  echo ""
  echo "---- renew: $domain ----"
  echo ""
  combineddomains=" $combineddomains -d $domain"
  #./certbot/certbot-auto certonly --email "$certemail" $certextra --agree-tos --non-interactive --standalone --rsa-key-size 4096 -d "$domain"
done
echo "$combineddomains"
./certbot/certbot-auto certonly --email "$certemail" $certextra --agree-tos --non-interactive --standalone --expand --rsa-key-size 4096 $combineddomains

systemctl start apache2
systemctl start nginx

echo ""
echo "---- update all tlsa entries ----"
echo ""

./generate_tlsa.bash

./prepare_dkim.bash

