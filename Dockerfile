FROM jekyll/jekyll:4.0

# When this is working, we'll use a bind mount, but to prevent f'ing up our
# real blog, COPY

VOLUME ["/srv/jekyll", "/usr/local/bundle"]
#COPY . /srv/jekyll
RUN id -u jekyll
RUN id -g jekyll

EXPOSE 4000
# If you use CMD, it will be overridden by command-line args
# With ENTRYPOINT, command-line args will be appended to the end
ENTRYPOINT ["/bin/sh"]
#ENTRYPOINT ["/usr/bin/env", "jekyll", "serve", "--source", "/srv/jekyll/blog"]
