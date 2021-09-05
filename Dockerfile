ARG name
ARG version

FROM golang:1.17 as build
WORKDIR /app
COPY . .
RUN go mod download && mkdir -p ./bin
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${GOARCH} go build -ldflags "-X main.gitTag=${version} -s -w" -o bin/${name} ./

FROM alpine
COPY --from=build /app/bin/${name} /bin/${name}
CMD ["${name}"]