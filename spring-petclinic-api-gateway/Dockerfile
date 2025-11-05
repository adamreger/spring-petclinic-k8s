FROM maven:3.9.6-eclipse-temurin-8 AS build
WORKDIR /workspace
ENV MAVEN_OPTS="-Xmx1536m -XX:MaxMetaspaceSize=256m"
COPY pom.xml .
COPY src ./src
RUN mvn -B clean package -DskipTests

FROM eclipse-temurin:8-jre
WORKDIR /app
COPY --from=build /workspace/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
