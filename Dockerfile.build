FROM openjdk:8u131-jdk

WORKDIR /code
COPY . ./

RUN ["./gradlew", "shadowJar", "--no-daemon"]
