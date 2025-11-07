FROM maven:3.9.6-eclipse-temurin-8 AS build
WORKDIR /workspace
COPY pom.xml ./pom.xml
COPY spring-petclinic-visits-service/pom.xml spring-petclinic-visits-service/pom.xml
COPY spring-petclinic-visits-service/src spring-petclinic-visits-service/src
WORKDIR /workspace/spring-petclinic-visits-service
RUN mvn -B clean package -DskipTests

FROM eclipse-temurin:8-jre
WORKDIR /app
COPY --from=build /workspace/spring-petclinic-visits-service/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
