#!/bin/bash

source le_paths.bash 
source domain_config.bash

src=$certbasepath
dest=$certdest 

for primdomain in $domainlist
do
  break
done

for domain in $domainlist
do
  echo $src/$primdomain
  cp -rfL $src/$primdomain $dest/$domain
done 
systemctl restart apache2
systemctl restart nginx

./delete_tlsa.bash

./rollover_dkim.bash

