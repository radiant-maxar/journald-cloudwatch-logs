FROM centos:7

ENV GIT_VERSION tweaks

MAINTAINER Brian Dwyer

RUN mkdir -p /go/bin && chmod -R 777 /go && cd /go \
		&& yum -y update \
		&& yum install -y centos-release-scl \
		&& yum -y install git \
		  openssl-devel systemd-devel \
  		go-toolset-7-golang \
		&& yum clean all

ENV GOPATH=/go \
		GOOS=linux \
		BASH_ENV=/opt/rh/go-toolset-7/enable \
		ENV=/opt/rh/go-toolset-7/enable \
		PROMPT_COMMAND=". /opt/rh/go-toolset-7/enable"

WORKDIR /go/src/journald-cloudwatch-logs

COPY . .

RUN set -ex \
    && . /opt/rh/go-toolset-7/enable \
    && go get -v \
    && go build -v .
