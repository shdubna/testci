PROGRAM_NAME = zabbix_exporter

#TAG=$(shell git describe --tags |cut -d- -f1)
TAG="v1.0.0"

LDFLAGS = -ldflags "-X main.gitTag=${TAG} -s -w"

help: ## Display this help screen.
	@echo "Makefile available targets:"
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  * \033[36m%-15s\033[0m %s\n", $$1, $$2}'

dep: ## Download the dependencies.
	go mod download

build: dep ## Build executable.
	mkdir -p ./bin
	CGO_ENABLED=0 GOOS=linux GOARCH=${GOARCH} go build ${LDFLAGS} -o bin/${PROGRAM_NAME} ./

clean: ## Clean build directory.
	rm -f ./bin/${PROGRAM_NAME}
	rmdir ./bin

docker-build: ## Build docker image
	docker build -t ${REGISTRY}/${IMAGE_NAME}:${TAG} .

docker-push: ## Push docker image to registry
	docker push ${REGISTRY}/${IMAGE_NAME}:${TAG}