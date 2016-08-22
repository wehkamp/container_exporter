FROM       alpine:3.4
EXPOSE     9104

LABEL container.name="wehkamp/prometheus-container-exporter"

ENV  GOPATH /go
ENV APPPATH $GOPATH/src/github.com/google/cadvisor

ADD . $APPPATH/

RUN apk add --update -t build-deps go git libc-dev gcc libgcc bash make linux-headers && \
	cd $APPPATH && \
	go get -d && make build && cp cadvisor /bin && \
	apk del --purge build-deps && \
	rm -rf $GOPATH

ENTRYPOINT [ "/bin/cadvisor", "-port", "9104" ]
