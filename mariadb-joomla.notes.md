
build:

  $ docker build . -t mymariadb

run:

  $ docker run --name mymariadb-test -p3306:3306 mymariadb

inspect:

  $ docker exec -it mymariadb-test bash

e.g.:

  root@e64748000afc:/#
  root@e64748000afc:/# mysql -u revamp -pxyz123 joomla
  MariaDB [joomla]> show tables;

