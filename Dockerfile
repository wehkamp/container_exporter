FROM       alpine:3.4
EXPOSE     9104

LABEL container.name="wehkamp/docker-prometheus-container-exporter"

ENV  GOPATH /go
ENV APPPATH $GOPATH/src/github.com/docker-infra/container-exporter

ADD *.go $APPPATH/

RUN apk add --update -t build-deps go git mercurial libc-dev gcc libgcc && \
	cd $APPPATH && \
	go get -d && go build -o /bin/container-exporter && \
	apk del --purge build-deps && \
	rm -rf $GOPATH

ENTRYPOINT [ "/bin/container-exporter" ]
