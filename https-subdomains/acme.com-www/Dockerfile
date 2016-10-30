# The MIT License (MIT)
#
# Copyright (c) 2016 Sean Quinn
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
FROM extesla/alpine
MAINTAINER "Sean Quinn <sean.quinn@extesla.com>"

COPY . /srv/www/www.acme.com
COPY conf/etc/nginx/sites /etc/nginx/sites
COPY conf/etc/nginx/sites-available/default.conf /etc/nginx/sites-available/www.acme.com

#: Identify the volumes in this container that we will want to import into
#: another container when we use the "volume-from" directive. In this case
#: we're mounting the web directory and the sites-available directory into
#: another container.
VOLUME /etc/nginx/sites
VOLUME /etc/nginx/sites-available
VOLUME /srv/www/www.acme.com

# Define working directory.
WORKDIR /srv/www/www.acme.com

CMD ["echo", "www.acme.com"]
