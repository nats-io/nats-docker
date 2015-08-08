FROM scratch

MAINTAINER Derek Collison <derek@apcera.com>

ADD gnatsd /gnatsd
ADD gnatsd.conf /gnatsd.conf

# Expose client, management, and routing/cluster ports
EXPOSE 4222 8222 6222

ENTRYPOINT ["/gnatsd", "-c", "/gnatsd.conf"]
CMD []