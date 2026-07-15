FROM ubuntu:noble

ARG LIBRA_VERSION=0.0.3
ARG LIBRA_CHECKSUM=9cd4955aefeeca1be540e96c08aa1fa915b1ee232532da879fd8c5241fd1025d
ARG LIBRA_REPOSITORY=https://github.com/Bornholm/libra
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y wget

RUN wget \
    -O libra.tar.gz \
    ${LIBRA_REPOSITORY}/releases/download/v${LIBRA_VERSION}/libra_${LIBRA_VERSION}_linux_arm64.tar.gz
    
RUN echo "${LIBRA_CHECKSUM} libra.tar.gz" | sha256sum --check --status

RUN mkdir -p /usr/local/bin
RUN tar -xzf libra.tar.gz -C /usr/local/bin libra
RUN chmod +x /usr/local/bin/libra
EXPOSE 8080
VOLUME /uploads

CMD ["/usr/local/bin/libra"]