FROM maven:3.9.6-eclipse-temurin-8 AS build
WORKDIR /workspace
COPY pom.xml ./pom.xml
COPY spring-petclinic-api-gateway/pom.xml spring-petclinic-api-gateway/pom.xml
COPY spring-petclinic-api-gateway/src spring-petclinic-api-gateway/src
WORKDIR /workspace/spring-petclinic-api-gateway
RUN mvn -B clean package -DskipTests

FROM eclipse-temurin:8-jre
WORKDIR /app
COPY --from=build /workspace/spring-petclinic-api-gateway/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
