FROM       alpine:edge
MAINTAINER Johannes 'fish' Ziemke <fish@docker.com> (@discordianfish)
EXPOSE     9104

ENV  GOPATH /go
ENV APPPATH $GOPATH/src/github.com/docker-infra/container-exporter

RUN echo http://dl-1.alpinelinux.org/alpine/edge/main > /etc/apk/repositories
ADD *.go $APPPATH/

WORKDIR $APPPATH

RUN apk add --update -t build-deps go git mercurial libc-dev gcc libgcc
RUN go get -d
RUN go build -o /bin/container-exporter

RUN apk del --purge build-deps && rm -rf $GOPATH

ENTRYPOINT [ "/bin/container-exporter" ]
