FROM golang:1.17 as build
LABEL stage=intermediate
WORKDIR /app
COPY . .
RUN make build

FROM alpine
COPY --from=build /app/bin/testci /bin/testci
CMD ["testci"]