#!/bin/bash

source le_paths.bash 
source domain_config.bash

src=$certbasepath
dest=$certdest 

cp -rfL $src/* $dest/.

systemctl restart apache2

./delete_tlsa.bash

