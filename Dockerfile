FROM openjdk:11-jre

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
  procps \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY build/libs/docker-olp-0.0.1-SNAPSHOT.jar /var/docker-olp-0.0.1-SNAPSHOT.jar

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
CMD ["default"]
