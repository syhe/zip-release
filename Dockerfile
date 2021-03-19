FROM debian:stable-slim

LABEL "maintainer"="TheDoctor0 <dawid.janik95@gmail.com>"
LABEL "repository"="https://github.com/TheDoctor0/zip-release"
LABEL "version"="0.4.0"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    zip \
    zstd \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
