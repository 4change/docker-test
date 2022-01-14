FROM mysql:5.7

MAINTAINER artbingo@artbingo.com

ENV TZ=Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY ./artbingo/1-artbingo.sql /docker-entrypoint-initdb.d

COPY ./artbingo/2-nacos.sql /docker-entrypoint-initdb.d