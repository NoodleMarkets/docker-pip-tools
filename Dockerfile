FROM python:3.6.1-alpine
MAINTAINER Michael Twomey <mick@twomeylee.name>

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        build-base \
        openssh \
        postgresql-dev \
        python3-dev \
        libffi \
        libffi-dev \
        openssl-dev \
        git

COPY requirements.txt /requirements.txt
RUN pip3 install -U setuptools pip wheel \
    && pip3 install -r /requirements.txt

WORKDIR /src

ARG SSH_KEY
RUN mkdir /root/.ssh
RUN echo "$SSH_KEY" > /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts && ssh-keyscan github.com >> /root/.ssh/known_hosts

CMD ["pip-compile", "-v", "--upgrade", "requirements.in"]
