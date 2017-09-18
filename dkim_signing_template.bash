echo 'path = "/var/lib/rspamd/dkim/$selector.key";'
echo "selector = \"$1\";"
echo 'use_esld = false'
echo ''
echo '### Enable DKIM signing for alias sender addresses'
echo 'allow_username_mismatch = true;'



