FROM alpine:3.6
RUN apk -v --update add \
        bash \
        git \
        groff \
        mailcap \
        less \
        py-pip \
        python \
        && \
    pip install --upgrade awscli==1.11.188 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*

# Download and Install hugo
ENV HUGO_VERSION 0.53
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-64bit

RUN mkdir /usr/local/hugo
ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /usr/local/hugo/
RUN tar xzf /usr/local/hugo/${HUGO_BINARY}.tar.gz -C /usr/local/hugo/ \
    && ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
    && rm /usr/local/hugo/${HUGO_BINARY}.tar.gz

COPY build.sh /
COPY docker-entrypoint.sh /
RUN chmod +x /*.sh

VOLUME /root/.aws
VOLUME /build
WORKDIR /build
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/build.sh"]
