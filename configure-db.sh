#!/bin/bash

# wait for MSSQL server to start
export STATUS=1
i=0

# We delay the execution of the configuration until the server startup is complete.
# We do so by grepping on the setup logs and waiting for the `Server setup is completed` message.
while [[ $STATUS -ne 0 ]] && [[ $i -lt 30 ]]; do
	i=$i+1
	/opt/mssql-tools/bin/sqlcmd -t 1 -U sa -P $SA_PASSWORD -Q "select 1" >> /dev/null
	STATUS=$?
done

if [ $STATUS -ne 0 ]; then 
	echo "Error: MSSQL SERVER took more than thirty seconds to start up."
	exit 1
fi

echo "======= MSSQL SERVER STARTED ========" | tee -a ./config.log
# Run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i setup.sql

echo "======= MSSQL CONFIG COMPLETE =======" | tee -a ./config.log
