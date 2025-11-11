# Generic Dockerfile for all PetClinic microservices
# Uses build args to specify which JAR to include

FROM eclipse-temurin:8-jre

# Create dedicated non-root user/group for the app
RUN addgroup --system spring && adduser --system --ingroup spring spring

# Set working directory
WORKDIR /app

# Accept JAR file path as build argument
ARG JAR_FILE
COPY ${JAR_FILE} app.jar

# Change ownership to non-root user
RUN chown spring:spring app.jar

# Switch to non-root user
USER spring:spring

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/actuator/health || exit 1

# Run the application
ENTRYPOINT ["java", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-XX:+UseContainerSupport", \
    "-XX:MaxRAMPercentage=75.0", \
    "-jar", \
    "app.jar"]
