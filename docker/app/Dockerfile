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

COPY go.mod go.sum ./
RUN go mod download

CMD ["go", "run", "./trampoline-chatbot/main.go"]

##
## Build
##
FROM golang:1.15.7-alpine as builder

ENV ROOT=/go/src/app
WORKDIR ${ROOT}

RUN apk update && apk add git
COPY go.mod go.sum ./
RUN go mod download

COPY . ${ROOT}
RUN CGO_ENABLED=0 GOOS=linux go build -o $ROOT/binary

##
## Deploy
##
FROM scratch as prod

RUN apk update \
  && apk add --no-cache curl \

ENV ROOT=/go/src/app
WORKDIR ${ROOT}
COPY --from=builder ${ROOT}/binary ${ROOT}

EXPOSE 8080
CMD ["/go/src/app/binary"]