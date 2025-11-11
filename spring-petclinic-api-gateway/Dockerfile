# ---------- Build stage ----------
FROM maven:3.9.6-eclipse-temurin-8 AS build
WORKDIR /workspace

# Copy root POM first (for dependency layer caching), then module poms, then sources
COPY pom.xml .
COPY spring-petclinic-api-gateway/pom.xml spring-petclinic-api-gateway/pom.xml
COPY spring-petclinic-customers-service/pom.xml spring-petclinic-customers-service/pom.xml
COPY spring-petclinic-vets-service/pom.xml spring-petclinic-vets-service/pom.xml
COPY spring-petclinic-visits-service/pom.xml spring-petclinic-visits-service/pom.xml

# Pre-fetch deps
RUN mvn -q -B -DskipTests dependency:go-offline

# Now copy sources
COPY . .

# Build ONLY this module and its deps; repackage creates the fat jar
RUN mvn -q -B -DskipTests -pl spring-petclinic-api-gateway -am package

# ---------- Runtime stage ----------
FROM eclipse-temurin:21-jre
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75"
WORKDIR /app

# Copy fat jar from the module
COPY --from=build /workspace/spring-petclinic-api-gateway/target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]