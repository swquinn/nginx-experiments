nginx-experiments
=================

This repository is meant to be a case study of nginx patterns, or more
specifically a sandbox where different examples of how to set up an nginx
server can be illustrated.

The experiments include:

* ___Simple HTTP Server.___ A straight-forward simple HTTP server.
* ___Simple HTTPS Server.___ An secure HTTPS server, with no access to port 80
* ___Multi-Context HTTPS Server.___ A server with multiple server blocks
  defined so that different applications can be served.
* ___Subdomains HTTPS Server.___ A server with multiple server blocks defined
  which identify subdomains for different applications.

[Docker](https://www.docker.com) is used to contain the experiments and
[docker-compose](https://www.docker.com/products/docker-compose) is used
to simplify the building of images.
