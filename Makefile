DOCKER_PREFIX ?= alexandreroman
IMAGE_TAG ?= latest
MVN_FLAGS ?= -DskipTests

.PHONY: all api-gateway customers vets visits

all: api-gateway customers vets visits

api-gateway:
	./mvnw -pl spring-petclinic-api-gateway -am clean package $(MVN_FLAGS)
	docker build --pull -f spring-petclinic-api-gateway/Dockerfile -t $(DOCKER_PREFIX)/spring-petclinic-k8s-api-gateway:$(IMAGE_TAG) .

customers:
	./mvnw -pl spring-petclinic-customers-service -am clean package $(MVN_FLAGS)
	docker build --pull -f spring-petclinic-customers-service/Dockerfile -t $(DOCKER_PREFIX)/spring-petclinic-k8s-customers:$(IMAGE_TAG) .

vets:
	./mvnw -pl spring-petclinic-vets-service -am clean package $(MVN_FLAGS)
	docker build --pull -f spring-petclinic-vets-service/Dockerfile -t $(DOCKER_PREFIX)/spring-petclinic-k8s-vets:$(IMAGE_TAG) .

visits:
	./mvnw -pl spring-petclinic-visits-service -am clean package $(MVN_FLAGS)
	docker build --pull -f spring-petclinic-visits-service/Dockerfile -t $(DOCKER_PREFIX)/spring-petclinic-k8s-visits:$(IMAGE_TAG) .
