FROM docker:dind

MAINTAINER Alex Gonzalez <alex@lindusembedded.com>

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
