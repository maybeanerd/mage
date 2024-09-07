# build xmage
FROM maven:3-jdk-8 AS builder

COPY . .
RUN ls -la  \
 && mvn clean install -DskipTests \ 
 && cd ./Mage.Client \
 && ls -la \
 && mvn package assembly:single \
 && cd ./Mage.Server \
 && ls -la \
 && mvn package assembly:single \
 && ls -la target \
 && unzip target/mage-server.zip -d xmage-server

FROM openjdk:8-jre

ENV XMAGE_DOCKER_SERVER_ADDRESS="0.0.0.0" \
    XMAGE_DOCKER_PORT="17171" \
    XMAGE_DOCKER_SEONDARY_BIND_PORT="17179" \
    XMAGE_DOCKER_MAX_SECONDS_IDLE="600" \
    XMAGE_DOCKER_AUTHENTICATION_ACTIVATED="false" \
    XMAGE_DOCKER_SERVER_NAME="mage-server"

EXPOSE 17171 17179
WORKDIR /xmage

# from being built
COPY --from=builder /Utils/xmage-server .

COPY dockerContainerStart.sh /xmage/

RUN chmod +x \
    /xmage/startServer.sh \
    /xmage/dockerContainerStart.sh

CMD [ "./dockerContainerStart.sh" ]