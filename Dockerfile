FROM gradle:jdk8 AS builder

ENV SRC=/home/gradle/src/try-vert
RUN mkdir -p $SRC
WORKDIR $SRC
COPY --chown=gradle:gradle . .
RUN gradle --no-daemon shadowJar

FROM openjdk:8-jre-alpine

WORKDIR /usr/bin
ENV JAR=try-vert-1.0-SNAPSHOT-fat.jar
COPY --from=builder /home/gradle/src/try-vert/build/libs/$JAR .

EXPOSE 80:8080

CMD java -jar ./$JAR


