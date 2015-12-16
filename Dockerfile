FROM golang:1.4.3

EXPOSE 8080

WORKDIR /go/src/app

RUN git clone https://github.com/bketelsen/captainhook.git /go/src/app && rm -rf .git && \ 
   go-wrapper download && \
   go-wrapper install && \
   mkdir /config

CMD app -echo -listen-addr 0.0.0.0:8080 -configdir /config
