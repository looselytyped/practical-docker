FROM openjdk:11-jdk as builder
WORKDIR /code
ADD . ./
RUN ["./gradlew", "shadowJar", "--no-daemon"]


FROM openjdk:11-jre
RUN apt-get update \
  && apt-get install -y \
  netcat  \
  && apt-get clean
EXPOSE 8080
COPY --from=builder /code/build/libs/docker-workshop-0.0.1-SNAPSHOT-fat.jar /var/app.jar
CMD ["java", "-jar", "/var/app.jar"]
