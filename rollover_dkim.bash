
mv /etc/rspamd/dkim_signing_new.conf /etc/rspamd/local.d/dkim_signing.conf

systemctl reload rspamd

