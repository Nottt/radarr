FROM ubuntu:18.04

 ARG DEBIAN_FRONTEND=noninteractive
 ENV LANG='C.UTF-8' LANGUAGE='C.UTF-8' LC_ALL='C.UTF-8'

# Add s6 script

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz /tmp
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

# Copy S6 init scripts

COPY s6/ /etc

# Add necessary packages

RUN apt-get update && apt install -y wget xz-utils tzdata software-properties-common > /dev/null 2>&1

HEALTHCHECK  --timeout=3s CMD wget --quiet --tries=1 --spider http://localhost:7878 || exit 1
EXPOSE 7878
VOLUME /config /app /data

ENTRYPOINT ["/init"]
