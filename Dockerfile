FROM golang:1.16-alpine AS build_base
RUN apk add --no-cache git
WORKDIR /tmp/go
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN go build -o ./out/main .

FROM alpine:3.13
RUN apk add ca-certificates
COPY --from=build_base /tmp/go/out/main /app/main
CMD ["/app/main"]
