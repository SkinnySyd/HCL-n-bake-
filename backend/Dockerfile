FROM maven:3.9.8-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-jammy AS prod

WORKDIR /app
EXPOSE 8080
COPY --from=build /app/target/backend.jar ./backend.jar
ENTRYPOINT ["java", "-jar", "./backend.jar"]