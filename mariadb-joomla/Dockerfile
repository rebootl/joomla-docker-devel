#
FROM mariadb:latest

ENV MYSQL_ROOT_PASSWORD example
ENV MYSQL_DATABASE joomla
ENV MYSQL_USER revamp
ENV MYSQL_PASSWORD xyz123

RUN sed -i -e s/#bind-address=0.0.0.0/bind-address=0.0.0.0/ /etc/mysql/my.cnf

ADD joomla.sql.gz /docker-entrypoint-initdb.d/joomla.sql.gz

EXPOSE 3306
