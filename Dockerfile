FROM mcr.microsoft.com/mssql/server:2019-latest

# Create a config directory inside the container
RUN mkdir -p /usr/config
# Set it as the working directory
WORKDIR /usr/config

# Bundle config source
# Copy all the source code from the project into the container image
COPY . /usr/config

# Make the setup scripts executable
USER root
RUN chmod +x /usr/config/entrypoint.sh
RUN chmod +x /usr/config/configure-db.sh
USER ${uid}:${gid}

ENTRYPOINT ["./entrypoint.sh"]

# Tail the setup logs to trap the process
CMD ["tail -f /dev/null"]

# Verify that scripts ran correctly
HEALTHCHECK --interval=15s CMD /opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD -Q "select 1" && grep -q "MSSQL CONFIG COMPLETE" ./config.log
