DOCKER_PREFIX ?= alexandreroman
IMAGE_TAG ?= latest
MVN_FLAGS ?= -DskipTests

.PHONY: all api-gateway customers vets visits

all: api-gateway customers vets visits

api-gateway:
	./mvnw -pl spring-petclinic-api-gateway -am clean package $(MVN_FLAGS)
	docker build --pull -t $(DOCKER_PREFIX)/spring-petclinic-k8s-api-gateway:$(IMAGE_TAG) spring-petclinic-api-gateway

customers:
	./mvnw -pl spring-petclinic-customers-service -am clean package $(MVN_FLAGS)
	docker build --pull -t $(DOCKER_PREFIX)/spring-petclinic-k8s-customers:$(IMAGE_TAG) spring-petclinic-customers-service

vets:
	./mvnw -pl spring-petclinic-vets-service -am clean package $(MVN_FLAGS)
	docker build --pull -t $(DOCKER_PREFIX)/spring-petclinic-k8s-vets:$(IMAGE_TAG) spring-petclinic-vets-service

visits:
	./mvnw -pl spring-petclinic-visits-service -am clean package $(MVN_FLAGS)
	docker build --pull -t $(DOCKER_PREFIX)/spring-petclinic-k8s-visits:$(IMAGE_TAG) spring-petclinic-visits-service
