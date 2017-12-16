# !/usr/bin/env bash
#
# initialize databases from a standard file
# creating databases as needed

DBLIST=$(mysql -e "SHOW DATABASES;" | tail +2)
select DB in $DBLIST "new..."
do
	if [[ $DB == "new..." ]]
	then
		printf "%b" "name for the new db: "
		read db test
		echo creating new database $DB
		mysql -e "CREATE DATABASE IF NOT EXISTS $DB;"
	fi

	if [ "$DB" ]
	then
		echo Initializing database: $DB
		mysql $DB < ourInit.sql
	fi
done

# prompt/variables for username and password should be added for this command depending on the mysql server you are connecting to, which is hopefully flipping secured w/ athentication and not-a-terrible password, will be adding that feature using variable
# shamelessly stolen from the older Oreilly book bash Cookbook by Carl Alhing, JP Vossen, & Cameron Newham
