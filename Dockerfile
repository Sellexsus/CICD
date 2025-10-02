FROM golang:1.24.1 AS builder

WORKDIR /app
COPY . .

RUN go mod download
RUN go build -o parcel-tracker

FROM debian:stable-slim
WORKDIR /app
COPY --from=builder /app/parcel-tracker .
COPY tracker.db .

CMD ["./parcel-tracker"]