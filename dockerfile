FROM openjdk:21-bullseye AS build-env-java

WORKDIR /app

RUN apt install curl

RUN curl -J https://meta.fabricmc.net/v2/versions/loader/1.21/0.15.11/1.0.1/server/jar > server.jar

RUN java -Xmx2G -jar server.jar nogui

RUN echo "eula=true" > eula.txt

RUN echo "max-players=5" >> server.properties
RUN echo "spawn-protection=0" >> server.properties
RUN echo "view-distance=32" >> server.properties

# COPY ./datapacks/ /app/world/datapacks/
COPY ./mods/ /app/mods/

RUN echo '[{"uuid":"99676602-849d-4f68-b247-cd835fddaee9","name":"Spudy48","level":2}]' >> ops.json

ENTRYPOINT ["java", "-Xmx4G", "-jar", "server.jar", "nogui"]