# syntax=docker/dockerfile:1.6

###############
# Global ARGs #
###############
ARG MAVEN_IMAGE=maven:3.9.6-eclipse-temurin-8
ARG RUNTIME_IMAGE=eclipse-temurin:8-jre

#########################
# Runtime stage (JRE 8) #
#########################
FROM ${RUNTIME_IMAGE} AS runtime

ARG MODULE
ARG PREBUILT_JAR_DIR=ci-artifacts/jars
WORKDIR /app

# Copy only the prebuilt artifact for the requested module to keep layers small.
COPY ${PREBUILT_JAR_DIR}/${MODULE}/ /tmp/prebuilt/

RUN set -eux; \
    test -f /tmp/prebuilt/app.jar || (echo "Missing prebuilt jar for ${MODULE} under ${PREBUILT_JAR_DIR}" >&2 && exit 1); \
    cp /tmp/prebuilt/app.jar /app/app.jar; \
    rm -rf /tmp/prebuilt

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
