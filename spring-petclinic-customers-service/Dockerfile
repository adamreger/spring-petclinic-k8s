FROM eclipse-temurin:8-jre-jammy
WORKDIR /app
# copy the built jar from this module's target/
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
