https
=====

This pattern explores setting up a _secure_ server using SSL. In the case of
this example, the server's certificate is self signed with RSA 2048-bit
encryption and a very, very, long validity period (25 years!).

## Pattern Tutorial

### Create your structure
As we did with the [http]() pattern, the first thing we want to do is
establish a structure for our components. The two images that we are going
to construct are: a custom [Nginx](http://nginx.org/) image, and an image
that represents the HTTPS `acme.com` server we will be running.

#### acme.com

The `acme.com` folder will be simple, just like the HTTP server, in fact we're
basically using the HTTP server as template for this one. Our structure will
basically have two folders: a `conf` folder which will hold our Nginx
configuration and a `public` folder that will contain the served content.

#### nginx

The `nginx` folder contains the custom Nginx installation.

### Generate Certificate

For the `HTTPS` pattern we'll be using a self-signed certificate that was
generated using the following command line:

```
$ openssl req -x509 -sha256 -nodes -days 9131 -newkey rsa:2048 -keyout acme.key -out acme.crt
```

## Building and running the pattern

```
$ docker-compose up
```
