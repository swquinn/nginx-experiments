https-subdomains
================

This Nginx experiment demonstrates how one might use Nginx as a reverse proxy
for servers defined as subdomains as opposed to URL contexts.

According to [Wikipedia](https://en.wikipedia.org/wiki/Reverse_proxy) a
reverse proxy is:

> _... a type of proxy server that retrieves resources on behalf of a client
> from one or more servers._

Jason Wilder addresses this same topic in his blog post:
[Automated Nginx Reverse Proxy for Docker](http://jasonwilder.com/blog/2014/03/25/automated-nginx-reverse-proxy-for-docker/),
published on March 25th, 2014.

### Before Running the Experiment

Subdomains rely on their context coming in as part of the host, rather than
the URI. As such, you will need to be able to specify `www` or `app` as part
of the hostname, e.g. `www.acme.com` or `app.acme.com`.

Unfortunately, if you've just been using IP addresses up until now to play
with these experiments, you will need to make some modifications to your
`/etc/hosts` (or equivalent) file such that you can reach the Nginx experiment
locally using the appropriate subdomains.

### Build

```
$ docker-compose build
```

### Run

```
$ docker-compose up
```
