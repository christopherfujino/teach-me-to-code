FROM ruby:2.7.0-preview1-buster

VOLUME ["/srv/jekyll", "/usr/local/bundle"]

ARG USER_ID
ARG GROUP_ID

WORKDIR "/srv/jekyll"

EXPOSE 4000
# If you use CMD, it will be overridden by command-line args
# With ENTRYPOINT, command-line args will be appended to the end
ENTRYPOINT ["/srv/jekyll/entrypoint.sh"]

RUN groupadd jekyll -g "$GROUP_ID"
RUN useradd -r -u "$USER_ID" -g "$GROUP_ID" --create-home jekyll
USER jekyll

CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0"]
