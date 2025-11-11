# syntax=docker/dockerfile:1.6

###############
# Global ARGs #
###############
ARG MAVEN_IMAGE=maven:3.9.6-eclipse-temurin-8
ARG RUNTIME_IMAGE=eclipse-temurin:8-jre

########################
# Build stage (Java 8) #
########################
FROM ${MAVEN_IMAGE} AS builder

ARG MODULE
# Fail fast if not provided
RUN test -n "$MODULE" || (echo "MODULE build-arg is required" && exit 1)

WORKDIR /workspace
COPY . .

# Build only the requested module (and its deps), skip tests
# Cache the local repo for faster rebuilds
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -pl "$MODULE" -am clean package -DskipTests

#########################
# Runtime stage (JRE 8) #
#########################
FROM ${RUNTIME_IMAGE} AS runtime

ARG MODULE
WORKDIR /app
COPY --from=builder /workspace/${MODULE}/target /tmp/target

# Find a Boot fat jar (exclude sources/javadoc/original/plain)
# and normalize to /app/app.jar
RUN set -eux; \
    ls -la /tmp/target; \
    JAR="$(ls -1 /tmp/target/*.jar 2>/dev/null | grep -Ev '(sources|javadoc|original|plain)\.jar$' | head -n1)"; \
    test -n "$JAR" || (echo "No runnable JAR found in /tmp/target. Did the module produce a Spring Boot fat jar?"; exit 1); \
    cp "$JAR" /app/app.jar; \
    rm -rf /tmp/target
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
