# Overview

- Build a docker image based on mcr.microsoft.com/mssql/server
- Configure the database with a database and user

# How to Run

## Clone this repo

```
git clone https://github.com/mcmoe/mssqldocker.git
```

## From DockerHub

The latest image is available on DockerHub

```
https://hub.docker.com/r/mcmoe/mssqldocker/
```

If you just want to use the image, you only need the `docker-compose.yml`.

Pulling the image

```
docker-compose pull mcmoe/mssqldocker
```

_Look at the available tags on DockerHub if you would like to use a specific version._

## Building the image for the first time

If you want to modify the files in the image, then you'll have to build locally.

Build with `docker-compose`:

```
docker-compose build
```

## Running the container

Modify the env variables to your liking in the `docker-compose.yml`.

Then spin up a new container using `docker-compose`

```
docker-compose up
```

_Note: MSSQL passwords must be at least 8 characters long, contain upper case, lower case and digits. Be careful not to use quotes `'` `"` and curly brackets `{` `}` for the password, as it may confuse the parser.
Configuration of the server will occur once it runs; the MSSQL env variables are required for this step._

_Note: add a `-d` to run the container in background._

## Connecting to the container

To connect to the SQL Server in the container, you can docker exec with sqlcmd.

```
docker exec -it mssqldev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD
```

## Inheriting from the image

You might want to inherit from the image and build your own in order to carry out more provisioning.
One example would be to import data into the database once it's setup.
To do so, in your docker file start with `FROM mcmoe/mssqldocker:latest`.
Then inject your command using `CMD`; it will ovveride the `CMD` in this image.
Currently, the `CMD` calls a tail on the logs to trap the process.
If you override it, you will have to worry about keeping the container running.

That's it!
