FROM scratch

COPY gnatsd /gnatsd
COPY gnatsd.conf /gnatsd.conf

# Expose client, management, and cluster ports
EXPOSE 4222 8222 6222

# Run via the configuration file
ENTRYPOINT ["/gnatsd", "-c", "/gnatsd.conf"]
CMD []