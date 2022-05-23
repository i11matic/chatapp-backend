FROM golang:1.18.2 as build

RUN mkdir /build-space

WORKDIR /build-space

COPY . .

RUN go mod download

RUN go build -o chatapp-backend


FROM golang:1.18.2

RUN mkdir /app

WORKDIR /app

COPY --from=build /build-space/chatapp-backend ./

ENV SERVER_IP="0.0.0.0"

ENV SERVER_PORT="8080"

EXPOSE $SERVER_PORT

CMD ["/app/chatapp-backend"]

