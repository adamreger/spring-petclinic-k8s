FROM maven:3.9.6-eclipse-temurin-8 AS build
WORKDIR /workspace
COPY pom.xml ./pom.xml
COPY spring-petclinic-vets-service/pom.xml spring-petclinic-vets-service/pom.xml
COPY spring-petclinic-vets-service/src spring-petclinic-vets-service/src
WORKDIR /workspace/spring-petclinic-vets-service
RUN mvn -B clean package -DskipTests

FROM eclipse-temurin:8-jre
WORKDIR /app
COPY --from=build /workspace/spring-petclinic-vets-service/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
