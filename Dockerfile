FROM alpine
COPY testci /bin/testci
ENTRYPOINT ["testci"]