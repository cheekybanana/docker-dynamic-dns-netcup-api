#!/bin/sh
set -e

echo "Starting dynamic DNS updater for Netcup (PHP version)..."

# Erstelle config.php aus ENV-Variablen
cat <<EOF > /app/config.php
<?php
define('CUSTOMERNR', '${CUSTOMER_NUMBER}');
define('APIKEY', '${API_KEY}');
define('APIPASSWORD', '${API_PASSWORD}');
define('DOMAINLIST', '${DOMAINS}');
define('USE_IPV4', true);
define('USE_IPV6', false);
define('CHANGE_TTL', true);
define('IPV4_ADDRESS_URL', 'https://get-ipv4.steck.cc');
define('IPV4_ADDRESS_URL_FALLBACK', 'https://ipv4.seeip.org');
define('IPV6_ADDRESS_URL', 'https://get-ipv6.steck.cc');
define('IPV6_ADDRESS_URL_FALLBACK', 'https://v6.ident.me/');
define('APIURL', 'https://ccp.netcup.net/run/webservice/servers/endpoint.php?JSON');
EOF

# Endlosschleife zum periodischen Ausführen
while true; do
    echo "Running update.php..."
    php /app/update.php
    echo "Next update in ${UPDATE_INTERVAL}s..."
    sleep "$UPDATE_INTERVAL"
done
