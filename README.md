Joomla development environment for an existing Joomla installation,
incl. mariadb database.

Using docker.

ToDo: Test/adapt it so it can be used for a new/empty installation.

## Database setup

Place the gzipped database dump of an existing Joomla installation under:

    ./mariadb-joomla/joomla.sql.gz

### New database

Comment out the database copy line in ./mariadb-joomla/Dockerfile:

    #ADD joomla.sql.gz /docker-entrypoint-initdb.d/joomla.sql.gz

## Joomla setup

### Existing installation (copy)

Unzip an existing Joomla installation to ./apache-joomla/joomla.

E.g., in ./apache-joomla/:

    $ tar -xzf joomla.tar.gz

### New installation

Download and unzip a new Joomla installation into ./apache-joomla/joomla/.

E.g., in ./apache-joomla/:

    $ mkdir joomla
    $ cd joomla/
    $ wget https://downloads.joomla.org/cms/joomla3/3-9-11/Joomla_3-9-11-Stable-Full_Package.zip?format=zip
    $ mv Joomla_3-9-11-Stable-Full_Package.zip?format=zip Joomla_3-9-11-Stable-Full_Package.zip
    $ unzip Joomla_3-9-11-Stable-Full_Package.zip

## docker-compose

Adapt names/ports as necessary in docker-compose.yaml.

If the database container name was changed this has to be adapted in the Joomla
configuration.php, for an existing installation. For new installations use the
new name in the browser setup dialog.

E.g. ./apache-joomla/joomla/configuration.php:

    public $host = 'mymariadb-test-2';

Other settings are adapted automatically.

Run:

    $ docker-compose build
    $ docker-compose up

## Notes

See apache-joomla.notes.md and mariadb-joomla.notes.md.
