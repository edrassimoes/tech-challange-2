FROM golang:1.21-alpine AS builder

WORKDIR /src

COPY go.mod go.sum* ./
RUN go mod download

COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -o /evaluation-service .

FROM alpine:3.20

WORKDIR /app

COPY --from=builder /evaluation-service ./evaluation-service

EXPOSE 8004
CMD ["./evaluation-service"]
