FROM moxm/java:1.8-full

MAINTAINER artbingo@artbingo.com

ENV TZ=Asia/Shanghai JAVA_OPTS="-Xms1024m -Xmx1024m -Xmn256m"

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir -p /artbingo-mng

WORKDIR /artbingo-mng

EXPOSE 4002

ADD ./artbingo-mng-biz.jar ./

CMD sleep 60;java $JAVA_OPTS -DNACOS_GROUP=$NACOS_GROUP -DNACOS_SERVER_GROUP=$NACOS_SERVER_GROUP -Dlogpath=$LOG_PATH -Dspring.profiles.active=$PROF_ACTIVE -DNACOS_HOST=$NACOS_HOST -jar artbingo-mng-biz.jar
