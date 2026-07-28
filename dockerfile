FROM alpine:3.20

ARG LIBRA_VERSION=0.0.3
ARG LIBRA_CHECKSUM=9cd4955aefeeca1be540e96c08aa1fa915b1ee232532da879fd8c5241fd1025d
ARG LIBRA_REPOSITORY=https://github.com/Bornholm/libra
RUN apk upgrade \
    && apk add \
    wget=1.24.5-r0 \
    tar=1.35-r2

RUN wget -O libra.tar.gz \
    ${LIBRA_REPOSITORY}/releases/download/v${LIBRA_VERSION}/libra_${LIBRA_VERSION}_linux_arm64.tar.gz \
    
    && echo "${LIBRA_CHECKSUM} libra.tar.gz" | sha256sum -c \

    && mkdir -p /usr/local/bin \
    && tar -xzf libra.tar.gz -C /usr/local/bin libra \
    && chmod +x /usr/local/bin/libra
EXPOSE 8080
VOLUME /uploads

RUN adduser -H -S -s /dev/null libra
USER libra

CMD ["/usr/local/bin/libra"]