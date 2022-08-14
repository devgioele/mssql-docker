# Microsoft SQL Server on Linux with setup

- Build a docker image based on mcr.microsoft.com/mssql/server
- Create a database
- Create a shadow database
- Create a `sysadmin` user
- Run a custom initialization script

The shadow database is useful for ORMs like [Prisma](https://prisma.io).

## How to Run

1. Copy the file `docker-compose-example.yml` and rename it to `docker-compose.yml`

2. Configure the environment variables to your needs

3. Run `docker compose up -d`

_Note: MSSQL passwords must be at least 8 characters long, contain upper case, lower case and digits. Be careful not to use quotes `'` `"` and curly brackets `{` `}` for the password, as it may confuse the parser.
Configuration of the server will occur once it runs; the MSSQL env variables are required for this step._

_Note: Add a `-d` to run the container in background._

## Connecting to the container

To connect to the SQL Server in the container and have an interactive shell:

```sh
docker exec -ti mssql bash -c '/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d dev'
```

_Note: This uses the environment variable `SA_PASSWORD` of the container, not the one of your shell._


## Publishing the image

Build the local image:

```sh
docker compose build
```

Tag the locally built image:

```sh
docker tag devgioele/mssql-docker:latest devgioele/mssql-docker:latest
```

Login to DockerHub:

```sh
docker login --username=<your_username>
```

Push the image to DockerHub:

```sh
docker push devgioele/mssql-docker
```
