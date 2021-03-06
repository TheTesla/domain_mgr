#!/bin/bash

source le_paths.bash 
source domain_config.bash

src=$certbasepath
dest=$certdest 

. ./primdomain.bash

for domain in $domainlist
do
  echo $src/$primdomain
  cp -rfL $src/$primdomain $dest/$domain
done 
systemctl restart apache2
systemctl restart nginx

./rollover_dkim.bash

