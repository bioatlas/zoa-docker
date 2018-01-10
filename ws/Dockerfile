FROM tomcat:8-alpine

COPY oztrack/target/oztrack.war $CATALINA_HOME/webapps/oztrack.war

RUN apk add --update tini openssl bash

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
	-O /wait-for-it.sh \
	&& chmod +x /wait-for-it.sh

ENTRYPOINT ["/sbin/tini", "--", "/wait-for-it.sh", "geoserver:8080", "-t", "10", "--"]

CMD ["catalina.sh", "run"]

