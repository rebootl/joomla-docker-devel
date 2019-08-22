Joomla development environment for an existing Joomla installation,
incl. mariadb database.

Using docker.

ToDo: Test/adapt it so it can be used for a new/empty installation.

## Database setup

Place the gzipped database dump of an existing Joomla installation under:

    ./mariadb-joomla/joomla.sql.gz

## Joomla setup

Unzip an existing Joomla installation to ./apache-joomla/joomla.

E.g., under apache joomla:

    $ tar -xzf joomla.tar.gz

## docker-compose

Adapt names/ports as necessary in docker-compose.yaml.

Run:

    $ docker-compose build
    $ docker-compose up

## Notes

See apache-joomla.notes.md and mariadb-joomla.notes.md.
