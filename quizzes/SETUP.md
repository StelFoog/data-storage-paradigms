# IMDB database on docker

## Intro

This is a small guide on how to set up the IMDB database on docker. This repo provides a `Dockerfile` used to create the docker image and a `Makefile` to help with creating and interacting with the database.

This guide is written based on \*nix systems, but should work for other systems – possibly with some slight modifications.

### Requirements

- Docker
- Support for Make (most systems have support by default).
- `imdb_dump.sql` file (it should be found somewhere on the course page). You can also find the gzipped file (from 2022) in this repo.

Since the file is gzipped when downloaded run `gzip -d imdb_dump.sql.gz` to unzip it.

### Steps

1. Clone this repo and navigate to the quizzes folder (e.g. `cd data-storage-paradigms/quizzes`).
2. `make create` to create the postgres database image. **NOTE:** This will automatically create a database called `imdb`, so there's no need to do it yourself.
3. `make start` to start a container of the image.
4. `make copy` to copy the `imdb_dump.sql` file into the container.
5. `make terminal` to connect to the container and open a terminal.
6. `psql -U postgres -d imdb` to connect to postgres and the `imdb` database.
7. `\i imdb_dump.sql` to load the data into the database.
8. Reload the database by disconnection to postgres (`exit`) and reconnecting (same way as done in step 6).
9. Ready to go! You can make sure that it works by writing `\dt`, which should print out all tables.

**Note:**

When you `exit` from postgres in step 8 you will only disconnect from postgres, you will still be connected to docker. To disconnect from docker you have to run `exit` once more.
