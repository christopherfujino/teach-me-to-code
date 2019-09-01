FROM jekyll/jekyll:4.0

VOLUME ["/srv/jekyll", "/usr/local/bundle"]

EXPOSE 4000
# If you use CMD, it will be overridden by command-line args
# With ENTRYPOINT, command-line args will be appended to the end
ENTRYPOINT ["/usr/bin/env", "jekyll", "serve"]
