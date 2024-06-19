# Use an official OpenJDK runtime as a parent image
FROM eclipse-temurin:20-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the local project files to the working directory in the container
COPY . .

# Add the Spring Boot executable JAR file
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

# Expose the port that the Spring Boot application will run on
EXPOSE 8080

# Set the environment variables required by Render
ENV PORT 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]