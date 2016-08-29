FROM scratch

RUN ["mkdir", "-p", "/config"]

COPY gnatsd /gnatsd
COPY gnatsd.conf /config/gnatsd.conf

# Expose client, management, and cluster ports
EXPOSE 4222 8222 6222

# Run via the configuration file
ENTRYPOINT ["/gnatsd", "-c", "/config/gnatsd.conf"]
CMD []
