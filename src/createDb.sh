# using a user with createdb and dropdb roles, or the user postgres
dropdb languagedepot-metadata --if-exists
createdb languagedepot-metadata
#./createdb.py
psql languagedepot-metadata < languagedepot-metadata.sql
