# Use an official OpenJDK runtime as a parent image
FROM eclipse-temurin:20-jdk AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven wrapper and POM file
COPY mvnw .
COPY .mvn .mvn

# Copy the rest of the project files to the working directory in the container
COPY src src
COPY pom.xml .

# Make the Maven wrapper script executable
RUN chmod +x mvnw

# Build the application
RUN ./mvnw clean package -DskipTests

# Use a second stage to create the final image
FROM eclipse-temurin:20-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the Spring Boot executable JAR file from the first stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port that the Spring Boot application will run on
EXPOSE 8080

# Set the environment variables required by Render
ENV PORT 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
