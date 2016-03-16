https-reverse-proxy
===================

This Nginx experiment investigates using Nginx as a reverse proxy in
conjunction with Docker.

According to [Wikipedia](https://en.wikipedia.org/wiki/Reverse_proxy) a
reverse proxy is:

> _... a type of proxy server that retrieves resources on behalf of a client
> from one or more servers._

Jason Wilder addresses this same topic in his blog post:
[Automated Nginx Reverse Proxy for Docker](http://jasonwilder.com/blog/2014/03/25/automated-nginx-reverse-proxy-for-docker/),
published on March 25th, 2014.

### Build

```
$ docker-compose build
```

### Run

```
$ docker-compose up
```
