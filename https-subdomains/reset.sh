docker rm \
  https_subdomains_acme_app_data \
  https_subdomains_acme_app_server \
  https_subdomains_acme_www_data \
  https_subdomains_acme_www_server \
  https_subdomains_acme_proxy
docker rmi \
  https-subdomains/acme-app-data \
  https-subdomains/acme-app-server \
  https-subdomains/acme-www-data \
  https-subdomains/acme-www-server \
  https-subdomains/acme
docker-compose build
