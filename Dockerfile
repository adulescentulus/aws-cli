FROM alpine:3.6
RUN apk -v --update add \
        bash \
        git \
        groff \
        jq \
        mailcap \
        less \
        py-pip \
        python \
        && \
    pip install --upgrade pip && \
    pip install certifi && \
    pip install --upgrade awscli==1.11.188 \
        awscli-local \
        jinja2 \
        python-magic \
        s3cmd==2.0.1 \
        troposphere && \
    apk -v --purge del \
        py-pip && \
    rm /var/cache/apk/*
RUN mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/awslabs/aws-iam-generator.git
VOLUME /root/.aws
VOLUME /build
WORKDIR /build

ENV AWS_DEFAULT_REGION=eu-central-1

CMD bash