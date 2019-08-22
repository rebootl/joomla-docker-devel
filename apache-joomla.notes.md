
build:

  $ docker build . -t myjoomla

run:

  $ docker run --name myjoomla-test \
      -v ${PWD}/joomla:/var/www/html \
      -p8085:80 myjoomla

start/stop:

  $ docker start myjoomla-test
  $ docker stop myjoomla-test

inspect:

  $ docker exec -it myjoomla-test bash

