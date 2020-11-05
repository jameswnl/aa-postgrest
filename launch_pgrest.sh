#!/bin/sh
echo "Starting swagger ui"
sh /usr/share/nginx/run.sh &
export PGRST_DB_URI="postgres://${POSTGRESQL_USER}:${POSTGRESQL_PASSWORD}@${POSTGRESQL_HOST}:${POSTGRESQL_PORT}/${POSTGRESQL_DATABASE}"
exec postgrest /etc/postgrest.conf

