
mv /etc/rspamd/dkim_signing_selector_new.conf /etc/rspamd/local.d/dkim_signing_selector.conf

systemctl reload rspamd

