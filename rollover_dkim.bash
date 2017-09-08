
mv /var/lib/rspamd/dkim_signing_selector_new.conf /var/lib/rspamd/local.d/dkim_signing_selector.conf

systemctl respamd reload

