FROM golang:1.21-alpine AS builder

WORKDIR /src

COPY go.mod go.sum* ./
RUN go mod download

COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -o /auth-service .

FROM alpine:3.20

WORKDIR /app

COPY --from=builder /auth-service ./auth-service

EXPOSE 8001
CMD ["./auth-service"]
