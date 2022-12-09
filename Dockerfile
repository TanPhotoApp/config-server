FROM eclipse-temurin:17-jre-alpine

ARG APPLICATION_USER=appuser

RUN adduser --system --group $APPLICATION_USER && \
    mkdir /app && \
    chown -R $APPLICATION_USER /app

COPY target/config-server.jar /app/config-server.jar

USER $APPLICATION_USER
WORKDIR /app

EXPOSE 8888
EXPOSE 5672

ENTRYPOINT [ "java", "-jar", "/app/config-server.jar" ]