ARG name
ARG version="0.1"

FROM golang:1.17 as build
WORKDIR /app
COPY Makefile go.mod main.go /app/
RUN make build

FROM alpine
COPY --from=build /app/bin/${name} /bin/${name}
ENTRYPOINT ["testci"]