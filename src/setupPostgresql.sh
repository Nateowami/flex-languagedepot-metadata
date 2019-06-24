#!/bin/bash
set -eux

cd "$(dirname "$0")" || exit

function createRole {
  echo "Setting up a database user."
  echo "You may be prompted for the password for the $USER user."
  echo "As you type the password no output will be shown."
  echo
  sudo -i -u postgres psql -c "CREATE ROLE $USER WITH LOGIN CREATEDB PASSWORD 'placeholder'"
}

# If There is no Postgre role with the username, create it
# psql will error if there is no role with the current user's name, e.g.:
# psql: FATAL:  role "user" does not exist
if psql postgres -c "" &> /dev/null
then
  echo "PostgreSQL user $USER already exists so it will not be created."
else
  createRole
fi

# Replaces "USERNAME" with the actual username in config.json
sed -i "s/USERNAME/$USER/" config.json

echo "Postgre setup done"
