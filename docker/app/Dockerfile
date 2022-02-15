##
## Develop
##
FROM golang:1.17.6-alpine as dev

ENV ROOT=/go/src/app
ENV CGO_ENABLED 0
ENV GO111MODULE=on

WORKDIR ${ROOT}

RUN apk update \
    && apk add git

COPY ./src/app/go.mod ./src/app/go.sum ./src/app/go.sum ./

RUN go mod tidy \
    && go install github.com/cosmtrek/air@v1.27.3

CMD ["air", "-c", ".air.toml"]

##
## Build
##
FROM golang:1.17.6-alpine as builder

ENV ROOT=/go/src/app

WORKDIR ${ROOT}

RUN apk update \
    && apk add git curl

COPY ./src/app/go.mod ./src/app/go.sum ./src/app/go.sum ./

RUN go mod tidy

COPY ./src/app ${ROOT}
RUN CGO_ENABLED=0 GOOS=linux go build -o $ROOT/binary

##
## Deploy
##
FROM scratch as prod

ENV ROOT=/go/src/app
WORKDIR ${ROOT}
COPY --from=builder ${ROOT}/binary ${ROOT}

ENV PORT=${PORT}
CMD ["/go/src/app/binary"]