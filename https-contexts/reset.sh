docker rm \
  https_contexts_acme_app_data \
  https_contexts_acme_app_server \
  https_contexts_acme_www_data \
  https_contexts_acme_www_server \
  https_contexts_acme_proxy
docker rmi \
  https-contexts/acme-app-data \
  https-contexts/acme-app-server \
  https-contexts/acme-www-data \
  https-contexts/acme-www-server \
  https-contexts/acme
docker-compose build
