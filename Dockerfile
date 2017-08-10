FROM golang:1.4.3 as build

RUN git clone https://github.com/bketelsen/captainhook.git /go/src/app && \
    cd /go/src/app && \
    go-wrapper download && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest

EXPOSE 8080

RUN apk --update add bash curl git wget openssh-client && \
    mkdir -p /go/src/app/ && \
    addgroup -g 1000 captain && \
    adduser -D -u 1000 -G captain -h /go/src/app captain && \
    mkdir /config && \
    rm -rf /var/cache/apk/*

COPY --from=build /go/src/app/app /go/bin/app
COPY entry.sh /

USER captain

ENTRYPOINT ["/entry.sh"]

CMD ["/go/bin/app", "-echo", "-listen-addr", "0.0.0.0:8080", "-configdir", "/config"]
