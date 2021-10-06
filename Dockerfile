# Build Stage
FROM golang:1.17-bullseye as build

WORKDIR /app
COPY ./ ./
RUN go build

# Runner Image
FROM debian:bullseye-slim as run
COPY --from=build /app/alertmanager-sns-forwarder .
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

CMD "./alertmanager-sns-forwarder"
