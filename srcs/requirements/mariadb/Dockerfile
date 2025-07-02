FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mysql_script.sh /usr/local/bin/mysql_script.sh
RUN chmod +x /usr/local/bin/mysql_script.sh

EXPOSE 3306

CMD ["mysql_script.sh"]