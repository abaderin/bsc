FROM golang:1.22.5-bookworm AS build
ARG TAG
WORKDIR /usr/src/app
#COPY go.mod go.sum ./
#RUN go mod download
COPY . .
RUN make all

FROM debian:bookworm
COPY --from=build /usr/src/app/build/bin/geth /usr/local/bin/geth
RUN useradd -u 10000 -m bsc-geth
USER bsc-geth
ENTRYPOINT [ "/usr/local/bin/geth" ]