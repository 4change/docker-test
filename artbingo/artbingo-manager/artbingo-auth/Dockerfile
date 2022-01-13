FROM moxm/java:1.8-full

MAINTAINER artbingo@artbingo.com

ENV TZ=Asia/Shanghai JAVA_OPTS="-Xms128m -Xmx256m -Djava.security.egd=file:/dev/./urandom"

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir -p /artbingo-auth

WORKDIR /artbingo-auth

EXPOSE 3000

ADD ./artbingo-auth.jar ./

CMD sleep 60;java $JAVA_OPTS -DNACOS_GROUP=$NACOS_GROUP -DNACOS_SERVER_GROUP=$NACOS_SERVER_GROUP -Dspring.profiles.active=$PROF_ACTIVE -DNACOS_HOST=$NACOS_HOST -jar artbingo-auth.jar
