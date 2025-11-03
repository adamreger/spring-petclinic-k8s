FROM maven:3.9.6-eclipse-temurin-8
WORKDIR /app
# copy the built jar from this module's target/
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
