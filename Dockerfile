# Use an official OpenJDK runtime as a parent image
FROM eclipse-temurin:20-jdk AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle wrapper and related files
COPY gradlew .
COPY gradle gradle

# Copy the rest of the project files to the working directory in the container
COPY src src
COPY build.gradle .
COPY settings.gradle .

# Make the Gradle wrapper script executable
RUN chmod +x gradlew

# Build the application
RUN ./gradlew clean build -x test

# Use a second stage to create the final image
FROM eclipse-temurin:20-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the Spring Boot executable JAR file from the first stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the port that the Spring Boot application will run on
EXPOSE 8080

# Set the environment variables required by Render
ENV PORT 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
